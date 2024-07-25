import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:urban_aura_flutter/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/auth/data/repository/auth_repository_impl.dart';
import 'package:urban_aura_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signin_usecase.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'core/common/bloc/app_user_cubit.dart';
import 'core/router/router.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initDioClient();
  initAuth();
}

Future<void> initDioClient() async {
  final Dio dio = Dio();
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  final authHeader = await serviceLocator<FlutterSecureStorage>().read(
    key: 'jwtToken',
  );
  List<Interceptor> interceptors = [];
  interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    if (options.path.contains('auth')) {
      return handler.next(options);
    }
    options.headers['Authorization'] = 'Bearer $authHeader';
    options.contentType = Headers.jsonContentType;
    return handler.next(options);
  }, onError: (error, handler) async {
    if (error.response?.statusCode == 401) {
      if (AppRouter.router.routeInformationProvider.value.uri.path
          .contains('signup') || AppRouter.router.routeInformationProvider.value.uri.path
          .contains('signin')) {
        return handler.reject(error);
      }
      await serviceLocator<FlutterSecureStorage>().deleteAll();
      serviceLocator<AppUserCubit>().logout(
          message:
              error.response?.data["message"] ?? 'Re-authentication required!');
    }
    return handler.reject(error);
  }));
  dio.interceptors.addAll(interceptors);
  serviceLocator.registerLazySingleton<Dio>(() => dio,instanceName: 'globalDio');
}

void initAuth() {
  serviceLocator
    ..registerLazySingleton<AppUserCubit>(
      () => AppUserCubit(
        storage: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SigninUsecase>(
      () => SigninUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SignupUsecase>(
      () => SignupUsecase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        signinUsecase: serviceLocator(),
        signupUsecase: serviceLocator(),
        storage: serviceLocator(),
        appUserCubit: serviceLocator()
      ),
    );
}
