import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';
import 'package:urban_aura_flutter/features/orders/presentation/bloc/order_bloc.dart';

class OrderInfoCard extends StatelessWidget {
  final OrderEntity _order;

  const OrderInfoCard({super.key, required OrderEntity orderEntity})
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
                'Info',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CustomDivider(),
            RichText(
              text: TextSpan(
                text: 'Order id : ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.id,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Status : ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.status.name.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Total Amount : ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                children: [
                  TextSpan(
                    text: '\$${_order.totalAmount}',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Placed at : ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.createdAt.toLocal().toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Last updated : ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                children: [
                  TextSpan(
                    text: _order.updatedAt.toLocal().toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
            if (_order.status.name == Status.placed.name)
              InkWell(
                splashFactory: InkSparkle.splashFactory,
                splashColor: AppPalette.primaryColor,
                onTap: () {
                  _showCancelOrderDialog(context: context);
                },
                child: const Text(
                  'Cancel order',
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ));
  }

  void _showCancelOrderDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final screenSize = MediaQuery.sizeOf(context);
        return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.black26)))),
                child: Text(
                  'No',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(letterSpacing: 2),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  context.read<OrderBloc>().add(
                        CancelOrderActionEvent(orderId: _order.id),
                      );
                },
                style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.black26)))),
                child: Text(
                  'Yes',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(letterSpacing: 2, color: Colors.red),
                ),
              )
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.all(24),
            title: Center(
              child: Text(
                'Are you sure',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(letterSpacing: 4, fontWeight: FontWeight.w600),
              ),
            ),
            content: SizedBox(
              width: screenSize.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cancel your order ? ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(letterSpacing: 2),
                  ),
                  const CustomDivider()
                ],
              ),
            ));
      },
    );
  }
}
