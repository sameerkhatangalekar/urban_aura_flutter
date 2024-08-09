import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';

class CartBuyNowButton extends StatelessWidget {
  const CartBuyNowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
         splashFactory: NoSplash.splashFactory,
          minimumSize:
              WidgetStateProperty.all(const Size(double.maxFinite, 48)),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.all(
            AppPalette.titleActive,
          ),
          shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
      onPressed: () {
        context.push('/checkout');
      },
      icon: SvgPicture.asset(
        'assets/icons/shopping_bag_icon.svg',
        theme: const SvgTheme(
          currentColor: Colors.red,
        ),
        color: Colors.white,
      ),
      label: const Text(
        'BUY NOW',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
