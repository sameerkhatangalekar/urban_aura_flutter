import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/app_user_cubit.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:urban_aura_flutter/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:urban_aura_flutter/init_dependencies.main.dart';

import 'core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>()..getCurrentUser(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ProductsBloc>()
            ..add(
              const GetProductsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CartBloc>()
            ..add(
              const GetCartEvent(),
            ),
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
