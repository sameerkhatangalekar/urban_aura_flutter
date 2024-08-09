import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:urban_aura_flutter/core/common/bloc/auth/app_user_cubit.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signin_usecase.dart';

import '../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase _signinUsecase;
  final SignupUsecase _signupUsecase;
  final FlutterSecureStorage _storage;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SigninUsecase signinUsecase,
    required SignupUsecase signupUsecase,
    required FlutterSecureStorage storage,
    required AppUserCubit appUserCubit,
  })  : _signinUsecase = signinUsecase,
        _signupUsecase = signupUsecase,
        _storage = storage,
        _appUserCubit = appUserCubit,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(const LoadingState()));

    on<SigninEvent>((event, emit) async {
      final result = await _signinUsecase(
        SignInParams(email: event.email, password: event.password),
      );
      await result.fold(
        (l) async => emit(SigninFailedState(message: l.message)),
        (r) async {
          await _storage.write(key: 'jwtToken', value: r).whenComplete(() {
            emit(const SigninSuccessfulState());
            _appUserCubit.login();
          });
        },
      );
    });
    on<SignupEvent>((event, emit) async {
      final result = await _signupUsecase(
        SignUpParams(
            email: event.email, name: event.name, password: event.password),
      );
      result.fold(
        (l) => emit(SignupFailedState(message: l.message)),
        (r) => emit(const SignupSuccessfulState()),
      );
    });
  }
}
