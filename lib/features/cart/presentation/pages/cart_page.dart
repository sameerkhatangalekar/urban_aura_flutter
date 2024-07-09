import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/config/mock_data.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_item.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close)),
              title: const Text(
                'CART',
                style: TextStyle(letterSpacing: 4),
              )),
          SliverList.separated(
              itemCount: homePageProducts.length,
              itemBuilder: (context, index) {
                return CartItem(productData: homePageProducts[index],);
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
