import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/footer.dart';

import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';
import 'package:urban_aura_flutter/features/products/presentation/widgets/color_selector.dart';
import 'package:urban_aura_flutter/features/products/presentation/widgets/image_slider.dart';
import 'package:urban_aura_flutter/features/products/presentation/widgets/size_selector.dart';


class ProductPage extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductPage({super.key, required this.productEntity});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  @override
  Widget build(BuildContext context) {
    debugPrint('Product rendered');
    return Scaffold(
      bottomNavigationBar: Container(
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
                child: ImageSlider(
              images: widget.productEntity.images,
              productId: widget.productEntity.id,
            )),
            padding: const EdgeInsets.only(
              top: 8,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productEntity.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        letterSpacing: 4, color: AppPalette.titleActive),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.productEntity.description,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.label,
                          wordSpacing: 2,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$${widget.productEntity.price.toStringAsFixed(0)}',
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
                      ColorSelector(colors: widget.productEntity.colors),
                      const SizedBox(
                        width: 20,
                      ),
                      SizeSelector(sizes: widget.productEntity.sizes)
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
