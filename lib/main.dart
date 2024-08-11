import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:urban_aura_flutter/core/common/bloc/auth/app_user_cubit.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:urban_aura_flutter/features/orders/presentation/bloc/order_bloc.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:urban_aura_flutter/features/search/presentation/bloc/search_bloc.dart';

import 'package:urban_aura_flutter/init_dependencies.main.dart';

import 'core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Bloc.observer = AppBlocObserver();
  await initDependencies();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>()..getCurrentUser(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ProductsBloc>()
            ..add(
              const GetProductsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CheckoutBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CheckoutBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<OrderBloc>(),
        )
      ],
      child: BlocListener<AppUserCubit, AppUserState>(
        listener: (context, state) {
          if (state is AppUserLoggedOutState) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(
                content: Text(
                  'Logged out successfully',
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          AppRouter.router.refresh();
        },
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: AppThemeData.theme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    ),
  );
}

class AppBlocObserver extends BlocObserver {
  ///We can run something, when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    ///We can check, if the BlocBase is a Bloc or a Cubit
    if (bloc is Cubit) {
      if (kDebugMode) {
        print("This is a Cubit");
      }
    } else {
      if (kDebugMode) {
        print("This is a Bloc");
      }
    }
  }

  ///We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print("an event Happened in $bloc the event is $event");
    }
  }

  ///We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    /// With this we can specifically know, when and what changed in our Bloc
    if (kDebugMode) {
      print(
          "There was a transition from ${transition.currentState} to ${transition.nextState}");
    }
  }

  ///We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print(
          "Error happened in $bloc with error $error and the stacktrace is $stackTrace");
    }
  }

  ///We can even run something, when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print("BLOC is closed");
    }
  }
}
