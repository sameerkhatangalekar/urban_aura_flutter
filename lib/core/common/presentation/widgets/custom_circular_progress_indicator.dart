import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 1,
      strokeCap: StrokeCap.round,
      color: AppPalette.primaryColor,
    );
  }
}
