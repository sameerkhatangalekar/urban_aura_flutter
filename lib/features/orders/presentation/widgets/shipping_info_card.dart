import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';

class ShippingInfoCard extends StatelessWidget {
  final OrderEntity _order;

  const ShippingInfoCard({super.key, required OrderEntity orderEntity})
      : _order = orderEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppPalette.inputBg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Shipping',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CustomDivider(),
            RichText(
              text: TextSpan(
                text: 'Name : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Contact : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.contact,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Address line 1 : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.lineOne,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'City : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'State : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.state,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Country : ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.shipping.country,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}