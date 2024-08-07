import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Hero(
              tag: product.id,
              child: CachedNetworkImage(
                imageUrl: product.images[0],
                fit: BoxFit.contain,
                errorWidget: (context, _, __) => Container(
                  color: getRandomColor(),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
                placeholder: (ctx, value) {
                  return Container(
                    color: getRandomColor(),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize,
                        color: AppPalette.body),
                  ),
                  Text(
                    product.brand,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize,
                        color: AppPalette.body),
                  ),
                  Text(
                    '\$${product.price}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppPalette.primaryColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      onTap: () => context.push(
        '/products/${product.name}',
        extra: product,
      ),
    );
  }
}
