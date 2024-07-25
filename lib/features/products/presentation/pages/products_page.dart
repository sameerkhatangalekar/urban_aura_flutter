import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_sliver_app_bar.dart';
import '../../../../core/config/mock_data.dart';
import '../../../../core/theme/app_palette.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(showBackButton: true,),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5),
                itemCount: homePageProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = homePageProducts[index];
                  return GestureDetector(
                    onTap: () => context.push(
                        '/products/${product.productName}',
                        extra: product),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Expanded(flex: 3,child:  Hero(
                         tag: product.id,
                         child: Image.network(
                           product.image,
                           fit: BoxFit.contain,
                         ),
                       ),),
                      Expanded(flex: 1,child:   Center(
                        child: Column(
                          children: [
                            Text(
                              '${product.productName} ${product.description}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize,
                                  color: AppPalette.body),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(0)}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppPalette.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
