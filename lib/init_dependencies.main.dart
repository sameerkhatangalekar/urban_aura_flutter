import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/add_to_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/get_addresses_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/remove_from_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/update_address_usecase.dart';
import 'package:urban_aura_flutter/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/auth/data/repository/auth_repository_impl.dart';
import 'package:urban_aura_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signin_usecase.dart';
import 'package:urban_aura_flutter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/cart/cart_remote_datasource.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/cart/cart_remote_datasource_impl.dart';
import 'package:urban_aura_flutter/core/common/data/repository/cart_repository_impl.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/cart_repository.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/decrement_cart_item_count_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/get_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/features/checkout/data/datasources/checkout_data_source.dart';
import 'package:urban_aura_flutter/features/checkout/data/datasources/checkout_data_source_impl.dart';
import 'package:urban_aura_flutter/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:urban_aura_flutter/features/checkout/domain/repository/checkout_repository.dart';
import 'package:urban_aura_flutter/features/checkout/domain/usecases/initiate_payment_usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/usecases/request_checkout_usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/usecases/show_payment_usecase.dart';
import 'package:urban_aura_flutter/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:urban_aura_flutter/features/orders/data/datasource/order_data_source.dart';
import 'package:urban_aura_flutter/features/orders/data/datasource/order_data_source_impl.dart';
import 'package:urban_aura_flutter/features/orders/data/repository/order_repository_impl.dart';
import 'package:urban_aura_flutter/features/orders/domain/repository/order_repository.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/cancel_order_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/get_orders_by_user_usecase.dart';
import 'package:urban_aura_flutter/features/orders/presentation/bloc/order_bloc.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_product_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_products_usecase.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/auth/app_user_cubit.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/increment_cart_item_count_usecase.dart';
import 'package:urban_aura_flutter/core/router/router.dart';
import 'package:urban_aura_flutter/features/products/data/datasource/products_remote_data_source.dart';
import 'package:urban_aura_flutter/features/products/data/datasource/products_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/products/data/repository/products_repository_impl.dart';
import 'package:urban_aura_flutter/features/products/domain/repository/products_repository.dart';
import 'package:urban_aura_flutter/features/search/data/datasource/search_data_source.dart';
import 'package:urban_aura_flutter/features/search/data/datasource/search_data_source_impl.dart';
import 'package:urban_aura_flutter/features/search/data/repository/search_repository_impl.dart';
import 'package:urban_aura_flutter/features/search/domain/repository/search_repository.dart';
import 'package:urban_aura_flutter/features/search/presentation/bloc/search_bloc.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/user/user_data_source.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/user/user_data_source_impl.dart';
import 'package:urban_aura_flutter/core/common/data/repository/user_repository_impl.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/create_address_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/delete_address_usecase.dart';

import 'core/constants.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initDioClient();
  initAuth();
  initUserBloc();
  initSearchBloc();
  initProductsBloc();
  initCartBloc();
  initCheckoutBloc();
  initOrdersBloc();
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

void initUserBloc() {
  serviceLocator
    ..registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
      ),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetAddressesUsecase>(
      () => GetAddressesUsecase(
        userRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CreateAddressUsecase>(
      () => CreateAddressUsecase(
        userRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<UpdateAddressUsecase>(
      () => UpdateAddressUsecase(
        userRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<DeleteAddressUsecase>(
      () => DeleteAddressUsecase(
        userRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<UserBloc>(
      () => UserBloc(
        updateAddressUsecase: serviceLocator(),
        createAddressUsecase: serviceLocator(),
        deleteAddressUsecase: serviceLocator(),
        getAddressesUsecase: serviceLocator(),
      ),
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

void initSearchBloc() {
  serviceLocator
    ..registerLazySingleton<HitsSearcher>(
      () => HitsSearcher(
        applicationID: algoliaAppId,
        apiKey: algoliaSearchKey,
        indexName: 'products',
      ),
    )
    ..registerLazySingleton<FilterState>(
      () => FilterState(),
    )
    ..registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImpl(
        productSearcher: serviceLocator(),
        filterState: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(
        searchDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<SearchBloc>(
      () => SearchBloc(
        searchRepository: serviceLocator(),
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
    ..registerLazySingleton<RemoveFromCartUsecase>(
      () => RemoveFromCartUsecase(
        cartRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CartBloc>(
      () => CartBloc(
        removeFromCartUsecase: serviceLocator(),
        getCartUsecase: serviceLocator(),
        incrementCartItemCountUsecase: serviceLocator(),
        decrementCartItemCountUsecase: serviceLocator(),
        addToCartUsecase: serviceLocator(),
      ),
    );
}

void initCheckoutBloc() {
  serviceLocator
    ..registerLazySingleton<Stripe>(() => Stripe.instance)
    ..registerLazySingleton<CheckoutDataSource>(
      () => CheckoutDataSourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
        stripe: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(
        checkoutDatasource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<RequestCheckoutUsecase>(
      () => RequestCheckoutUsecase(
        checkoutRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<InitiatePaymentUsecase>(
      () => InitiatePaymentUsecase(
        checkoutRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<ShowPaymentSheetUsecase>(
      () => ShowPaymentSheetUsecase(
        checkoutRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CheckoutBloc>(
      () => CheckoutBloc(
          requestCheckoutUsecase: serviceLocator(),
          initiatePaymentUsecase: serviceLocator(),
          showPaymentSheetUsecase: serviceLocator()),
    );
}

void initOrdersBloc() {
  serviceLocator
    ..registerLazySingleton<OrderDataSource>(
      () => OrderDataSourceImpl(
        dio: serviceLocator(instanceName: 'globalDio'),
      ),
    )
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(
        orderDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetOrdersByUserUsecase>(
      () => GetOrdersByUserUsecase(
        orderRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<CancelOrderByIdUsecase>(
      () => CancelOrderByIdUsecase(
        orderRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetOrderByIdUsecase>(
      () => GetOrderByIdUsecase(
        orderRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<OrderBloc>(
      () => OrderBloc(
          getOrderByIdUsecase: serviceLocator(),
          cancelOrderByIdUsecase: serviceLocator(),
          getOrdersByUserUsecase: serviceLocator()),
    );
}
