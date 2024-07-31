import 'package:flutter/material.dart';

class SpacerBox extends StatelessWidget {
  final double height;
  const SpacerBox({super.key , this.height = 28});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
    );
  }
}
