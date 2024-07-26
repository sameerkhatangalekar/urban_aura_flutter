import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/widgets/footer.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

import '../../../../core/common/widgets/custom_sliver_app_bar.dart';

class ProductPage extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductPage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar:  Container(
        padding: const EdgeInsets.all(4),
        color: AppPalette.titleActive,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'ADD TO BASKET',
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            showBackButton: true,
          ),
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: Hero(
                tag: productEntity.id,
                child: CachedNetworkImage(
                    imageUrl:  productEntity.images[0],
                    width: size.width,
                    height: size.height * 0.6,
                    fit: BoxFit.contain),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productEntity.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        letterSpacing: 4, color: AppPalette.titleActive),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(productEntity.description,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppPalette.label, wordSpacing: 2)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$${productEntity.price.toStringAsFixed(0)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppPalette.secondaryColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text('Color',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPalette.label, wordSpacing: 2)),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: AppPalette.secondaryColor,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: AppPalette.label,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: AppPalette.placeHolder,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Size',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPalette.label, wordSpacing: 2)),
                      const SizedBox(
                        width: 4,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: const Center(
                          child: Center(child: Text('S')),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: const Center(
                          child: Center(child: Text('M')),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppPalette.placeHolder, width: 0.5),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(2),
                        child: const Center(
                          child: Center(child: Text('L')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //TODO FILL RELATIVE PRODUCT DATA
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
            ),
          ),

          const SliverToBoxAdapter(
            child: Footer(),
          )
        ],
      ),
    );
  }
}
