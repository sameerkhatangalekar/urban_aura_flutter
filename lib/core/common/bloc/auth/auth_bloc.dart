
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signout_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signup_usecase.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signin_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signin_with_google_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final SigninUsecase _signinUsecase;
  final SignupUsecase _signupUsecase;
  final SigninWithGoogleUsecase _signinWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;
  final FlutterSecureStorage _storage;

  AuthBloc({
    required FirebaseAuth firebaseAuth,
    required SigninUsecase signinUsecase,
    required SignupUsecase signupUsecase,
    required SigninWithGoogleUsecase signinWithGoogleUsecase,
    required SignOutUsecase signOutUsecase,
     required FlutterSecureStorage storage,
  })  : _signinUsecase = signinUsecase,
        _signinWithGoogleUsecase = signinWithGoogleUsecase,
        _signupUsecase = signupUsecase,
        _signOutUsecase = signOutUsecase,
        _firebaseAuth = firebaseAuth,
        _storage = storage,
        super(const AuthInitial()) {

    on<AuthEvent>((event, emit) {
      if (event is! AuthStatusRequestedEvent) {
        emit(const LoadingState());
      }
    });
    on<AuthStatusRequestedEvent>((event, emit) async {
      final user = _firebaseAuth.currentUser;
      final token = await _storage.containsKey(key: 'jwtToken');
      if (!token && user == null) {
        emit(const AuthInitial());
      } else {
        emit(const SigninSuccessfulState());
      }

    });
    on<SigninEvent>((event, emit) async {
      final result = await _signinUsecase(
        SignInParams(email: event.email, password: event.password),
      );
      await result.fold(
        (l)   async => emit(SigninFailedState(message: l.message)),
        (r) async {

          emit(const SigninSuccessfulState());
          await _storage.write(key: 'jwtToken', value: r).whenComplete(() {
            emit(const SigninSuccessfulState());
          });
        },
      );
    });
    on<SignupEvent>((event, emit) async {
      final result = await _signupUsecase(
        SignUpParams(
            email: event.email, name: event.name, password: event.password),
      );
      await result.fold(
        (l) async => emit(SignupFailedState(message: l.message)),
        (r) async {

          await _storage.write(key: 'jwtToken', value: r);
          emit(const SigninSuccessfulState());
        },
      );
    });
    on<GoogleSigninEvent>((event, emit) async {
      final result = await _signinWithGoogleUsecase(const NoParams());
      await result.fold(
        (l) async => emit(SigninFailedState(message: l.message)),
        (r) async {
          await _storage.write(key: 'jwtToken', value: r).whenComplete(() {
            emit(const SigninSuccessfulState());
          });
        },
      );
    });
    on<SignOutEvent>((event, emit) async {
      final result = await _signOutUsecase(const NoParams());
      result.fold(
        (l) => emit(SignOutFailedState(message: l.message)),
        (r) {
           emit(const SignedOutState());
        },
      );
    });
  }
}
