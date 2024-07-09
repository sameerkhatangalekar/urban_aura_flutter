
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';

import 'core/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp.router(
    theme: AppThemeData.theme,
    debugShowCheckedModeBanner: false,
    routerConfig: AppRouter.router,
  ));
}
