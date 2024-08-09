import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_state.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_buy_now_button.dart';

class CartSummarySheet extends StatelessWidget {
  const CartSummarySheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUB TOTAL',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  BlocSelector<CartBloc, CartState, double>(
                    selector: (state) {
                      if (state is CartSuccessState) {
                        return state.cartEntity.cartTotal;
                      }

                      return 0.0;
                    },
                    builder: (BuildContext context, double cartTotal) {
                      return Text(
                        '\$$cartTotal',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            color: AppPalette.secondaryColor),
                      );
                    },
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Text(
                'Shipping charges, taxes and discount codes are calculated at the time of accounting.',
                maxLines: 4,
                textAlign: TextAlign.justify,
                style: TextStyle(color: AppPalette.placeHolder),
              ),
            ),
            const CartBuyNowButton(),
          ],
        )
      ],
    );
  }
}
