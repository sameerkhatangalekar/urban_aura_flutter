import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/features/auth/presentation/pages/signin_page.dart';
import 'package:urban_aura_flutter/features/auth/presentation/pages/signup_page.dart';
import 'package:urban_aura_flutter/features/cart/presentation/pages/cart_page.dart';
import 'package:urban_aura_flutter/features/checkout/presentation/pages/checkout_page.dart';
import 'package:urban_aura_flutter/features/home/presentation/pages/home_page.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';
import 'package:urban_aura_flutter/features/products/presentation/pages/product_page.dart';
import 'package:urban_aura_flutter/features/products/presentation/pages/products_page.dart';
import 'package:urban_aura_flutter/features/search/presentation/pages/search_page.dart';
import 'package:urban_aura_flutter/features/user/presentation/pages/user_page.dart';

import '../common/bloc/auth/app_user_cubit.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/signin',
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(child: Text('Page Not Found')),
      );
    },
    routes: [
      // GoRoute(
      //   path: '/signin',
      //   builder: (context, state) {
      //     return SignInScreen(
      //       providers: [
      //         GoogleProvider(clientId: '1037376833956-s8rg39e7of58d6bj6lid4fhaaimrde0k.apps.googleusercontent.com')
      //       ],
      //       actions: [
      //         AuthStateChangeAction<SignedIn>((context, state) {
      //           Navigator.pushReplacementNamed(context, '/profile');
      //         }),
      //       ],
      //     );
      //   },
      // ),

      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const SignInPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const SignupPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
        path: '/user',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const UserPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
        path: '/search',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const SearchPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
          path: '/products',
          builder: (context, state) => const ProductsPage(),
          routes: [
            GoRoute(
              path: ':productName',
              builder: (context, state) => ProductPage(
                productEntity: state.extra as ProductEntity,
              ),
            ),
          ]),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const CartPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child: const CheckoutPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
              });
        },
      ),
    ],
    redirect: _guard,
  );

  static String? _guard(BuildContext context, GoRouterState state) {
    if (state.matchedLocation == '/signup' &&
        context.read<AppUserCubit>().state is AppUserLoggedOutState) {
      return null;
    }

    if (context.read<AppUserCubit>().state is AppUserLoggedOutState) {
      return '/signin';
    }
    if ((context.read<AppUserCubit>().state is AppUserLoggedInState &&
            state.matchedLocation == '/') ||
        (context.read<AppUserCubit>().state is AppUserLoggedInState &&
            state.matchedLocation == '/signin')) {
      return '/';
    }
    return null;
  }
}
