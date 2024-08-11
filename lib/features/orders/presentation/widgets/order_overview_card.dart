import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';

class OrderOverViewCard extends StatelessWidget {
  final OrderEntity _orderEntity;

  const OrderOverViewCard({super.key, required OrderEntity orderEntity})
      : _orderEntity = orderEntity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
        onTap: () =>
            context.push('/orders/${_orderEntity.id}', extra: _orderEntity.id),
      child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: AppPalette.inputBg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Order # ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: AppPalette.label,
                                    fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                            text: _orderEntity.id,
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppPalette.primaryColor,
                                    ),
                          )
                        ])),
                    RichText(
                        text: TextSpan(
                            text: 'Order placed : ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: AppPalette.label,
                                    fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                            text: _orderEntity.createdAt.toLocal().toString(),
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppPalette.primaryColor,
                                    ),
                          )
                        ])),
                    RichText(
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Ship to : ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppPalette.label, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '${_orderEntity.shipping.name}, ',
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppPalette.primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Total : ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppPalette.label, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '\$${_orderEntity.totalAmount}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: AppPalette.primaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width * 0.2,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: _orderEntity.orderItems.first.images.first,
                        fit: BoxFit.contain,
                        placeholder: (context, _) => Container(
                          color: getRandomColor(),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '+${_orderEntity.orderItems.length}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              )
            ],
          )),
    );


  }
}
