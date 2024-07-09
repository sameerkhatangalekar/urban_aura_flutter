import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/config/mock_data.dart';
import 'package:urban_aura_flutter/features/cart/presentation/pages/cart_page.dart';
import 'package:urban_aura_flutter/features/home/presentation/pages/home_page.dart';
import 'package:urban_aura_flutter/features/products/presentation/product_page.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(child: Text('Page Not Found')),
      );
    },
    routes: [
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
        path: '/products/:productName',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child:  ProductPage(productData:  state.extra as ProductData,),
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
        path: '/cart',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              child:  const CartPage(),
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
  );
}
