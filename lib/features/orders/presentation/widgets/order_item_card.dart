import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemEntity _orderItemEntity;

  const OrderItemCard({super.key, required OrderItemEntity orderItemEntity})
      : _orderItemEntity = orderItemEntity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppPalette.inputBg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.24,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: _orderItemEntity.images.first,
                  fit: BoxFit.contain,
                  placeholder: (context, _) => Container(
                    color: getRandomColor(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  _orderItemEntity.name,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 3, color: AppPalette.titleActive),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(_orderItemEntity.brand,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppPalette.label, wordSpacing: 2)),
                const SizedBox(
                  height: 4,
                ),

                Text(
                  '\$${_orderItemEntity.price * _orderItemEntity.quantity} ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppPalette.secondaryColor),
                ),
                Text(
                  'Qty :  ${_orderItemEntity.quantity} ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppPalette.label),
                ),
                Row(
                  children: [
                    Text(
                      'Size :  ${_orderItemEntity.size} ',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppPalette.label),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Color :  ${_orderItemEntity.color} ',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppPalette.label),
                    ),
                  ],
                )
              ],
            ),)
          ],
        ));
  }
}
