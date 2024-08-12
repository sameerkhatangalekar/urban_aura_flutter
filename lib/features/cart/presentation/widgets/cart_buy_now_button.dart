import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_state.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/cart_entity.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';

class CartBuyNowButton extends StatelessWidget {
  const CartBuyNowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, List<CartItem>>(selector: (state) {
      if (state is CartSuccessState) {
        return state.cartEntity.cart;
      }
      return const [];
    }, builder: (context, state) {
      return TextButton.icon(
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            minimumSize:
                WidgetStateProperty.all(const Size(double.maxFinite, 48)),
            backgroundColor: WidgetStateProperty.all(AppPalette.titleActive),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            overlayColor: WidgetStateProperty.all(Colors.white10)),
        onPressed: () {
          if(state.isNotEmpty)
            {
              context.push('/checkout');
            }
          else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Cart is empty!'),
                ),
              );
          }
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
    });
  }
}
