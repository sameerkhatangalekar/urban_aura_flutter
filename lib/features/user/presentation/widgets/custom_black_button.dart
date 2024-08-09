import 'package:flutter/material.dart';

class CustomBlackButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String label;

  const CustomBlackButton({
    super.key,
    required this.voidCallback,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: WidgetStateProperty.all(Colors.black),
        minimumSize: WidgetStateProperty.all(Size(size.width, 48)),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      onPressed: voidCallback,
      iconAlignment: IconAlignment.end,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
