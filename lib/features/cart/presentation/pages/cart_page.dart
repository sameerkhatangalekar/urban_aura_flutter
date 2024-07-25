import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/config/mock_data.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: size.height * 0.25,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUB TOTAL',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$240',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        color: AppPalette.secondaryColor),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '*shipping charges, taxes and discount codes are calculated at the time of accounting',
                maxLines: 2,
                style: TextStyle(color: AppPalette.placeHolder),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              color: AppPalette.titleActive,
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    context.push('/checkout');
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/shopping_bag_icon.svg',
                    theme: const SvgTheme(
                      currentColor: Colors.white,
                    ),
                  ),
                  label: const Text(
                    'BUY NOW',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(
                onPressed: () => context.pop(), icon: const Icon(Icons.close)),
            title: const Text(
              'CART',
              style: TextStyle(letterSpacing: 4),
            ),
          ),
          SliverList.separated(
              itemCount: homePageProducts.length,
              itemBuilder: (context, index) {
                return CartItem(
                  productData: homePageProducts[index],
                );
              },
              separatorBuilder: (context, miniIndex) {
                return const SizedBox(
                  height: 4,
                );
              })
        ],
      ),
    );
  }
}
