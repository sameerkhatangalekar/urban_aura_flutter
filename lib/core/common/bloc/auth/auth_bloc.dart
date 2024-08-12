import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/auth_repository.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signout_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signup_usecase.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signin_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/auth/signin_with_google_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SigninUsecase _signinUsecase;
  final SignupUsecase _signupUsecase;
  final SigninWithGoogleUsecase _signinWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;
  late final StreamSubscription<bool> _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required SigninUsecase signinUsecase,
    required SignupUsecase signupUsecase,
    required SigninWithGoogleUsecase signinWithGoogleUsecase,
    required SignOutUsecase signOutUsecase,
  })  : _signinUsecase = signinUsecase,
        _authRepository = authRepository,
        _signinWithGoogleUsecase = signinWithGoogleUsecase,
        _signupUsecase = signupUsecase,
        _signOutUsecase = signOutUsecase,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is! _AppUserChanged) {
        emit(const LoadingState());
      }
    });
    on<_AppUserChanged>((event, emit) {
      if (event.isAuthenticated) {
        emit(const SigninSuccessfulState());
      } else {
        emit(const SignedOutState());
      }
    });
    on<SigninEvent>((event, emit) async {
      final result = await _signinUsecase(
        SignInParams(email: event.email, password: event.password),
      );
      result.fold(
        (l) => emit(SigninFailedState(message: l.message)),
        (r) {},
      );
    });
    on<SignupEvent>((event, emit) async {
      final result = await _signupUsecase(
        SignUpParams(
            email: event.email, name: event.name, password: event.password),
      );
      result.fold(
        (l) => emit(SignupFailedState(message: l.message)),
        (r) {},
      );
    });
    on<GoogleSigninEvent>((event, emit) async {
      final result = await _signinWithGoogleUsecase(const NoParams());
      result.fold(
        (l) => emit(SigninFailedState(message: l.message)),
        (r) {},
      );
    });
    on<SignOutEvent>((event, emit) async {
      final result = await _signOutUsecase(const NoParams());
      result.fold(
        (l) => emit(SignOutFailedState(message: l.message)),
        (r) {
        },
      );
    });
    _userSubscription = _authRepository.userState.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
