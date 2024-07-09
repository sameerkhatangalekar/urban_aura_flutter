import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

class DiamondIndicator extends StatelessWidget {
  final bool isActive;

  const DiamondIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: AnimatedContainer(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
            color: isActive ? AppPalette.secondaryColor : Colors.white,
            border:  isActive ? Border.all( width: 0.0,color: Colors.transparent) :  Border.all(color:  AppPalette.label, width: 0.6)
        ), duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
    );
  }
}
