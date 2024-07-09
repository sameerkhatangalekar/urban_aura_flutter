
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/widgets/diamond_indicator.dart';

import '../../theme/app_palette.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
            indent: size.width * 0.3,
            endIndent: size.width * 0.3,
            thickness: 0.5,
            color: AppPalette.label),
        const DiamondIndicator(),
      ],
    );
  }
}
