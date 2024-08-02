import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/add_to_cart_usecase.dart';
import 'package:urban_aura_flutter/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/auth/data/repository/auth_repository_impl.dart';
import 'package:urban_aura_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signin_usecase.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/cart_remote_datasource.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/cart_remote_datasource_impl.dart';
import 'package:urban_aura_flutter/core/common/data/repository/cart_repository_impl.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/cart_repository.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/decrement_cart_item_count_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/get_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_product_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_products_usecase.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/app_user_cubit.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/increment_cart_item_count_usecase.dart';
import 'package:urban_aura_flutter/core/router/router.dart';
import 'package:urban_aura_flutter/features/products/data/datasource/products_remote_data_source.dart';
import 'package:urban_aura_flutter/features/products/data/datasource/products_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/products/data/repository/products_repository_impl.dart';
import 'package:urban_aura_flutter/features/products/domain/repository/products_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initDioClient();
  initAuth();
  initProductsBloc();
  initCartBloc();
}

Future<void> initDioClient() async {
  final Dio dio = Dio();
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  List<Interceptor> interceptors = [];
  interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final authHeader = await serviceLocator<FlutterSecureStorage>().read(
          key: 'jwtToken',
        );

        if (options.path.contains('auth')) {
          return handler.next(options);
        }
        options.headers['Authorization'] = 'Bearer $authHeader';
        options.contentType = Headers.jsonContentType;
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          if (AppRouter.router.routeInformationProvider.value.uri.path
                  .contains('signup') ||
              AppRouter.router.routeInformationProvider.value.uri.path
                  .contains('signin')) {
            return handler.reject(error);
          }
          await serviceLocator<FlutterSecureStorage>().deleteAll();
          serviceLocator<AppUserCubit>().logout(
              message: error.response?.data["message"] ??
                  'Re-authentication required!');
        }
        return handler.reject(error);
      },
    ),
  );
  dio.interceptors.addAll(interceptors);
  serviceLocator.registerLazySingleton<Dio>(() => dio,
      instanceName: 'globalDio');
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
          appUserCubit: serviceLocator()),
    );
}

void initProductsBloc() {
  serviceLocator
    ..registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
      ),
    )
    ..registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(
        productsRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(
        productsRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetProductsByIdUsecase>(
      () => GetProductsByIdUsecase(
        productsRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(
        getProductsUsecase: serviceLocator(),
        getProductsByIdUsecase: serviceLocator(),
      ),
    );
}

void initCartBloc() {
  serviceLocator
    ..registerLazySingleton<CartRemoteDatasource>(
      () => CartRemoteDatasourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
      ),
    )
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        cartRemoteDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetCartUsecase>(
      () => GetCartUsecase(
        cartRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<IncrementCartItemCountUsecase>(
      () => IncrementCartItemCountUsecase(
        cartRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<DecrementCartItemCountUsecase>(
      () => DecrementCartItemCountUsecase(
        cartRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AddToCartUsecase>(
          () => AddToCartUsecase(
        cartRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CartBloc>(
      () => CartBloc(
          getCartUsecase: serviceLocator(),
          incrementCartItemCountUsecase: serviceLocator(),
          decrementCartItemCountUsecase: serviceLocator(),
          addToCartUsecase: serviceLocator()
      ),
    );
}
