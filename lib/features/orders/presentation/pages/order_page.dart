import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/features/orders/presentation/bloc/order_bloc.dart';
import 'package:urban_aura_flutter/features/orders/presentation/widgets/order_info_card.dart';
import 'package:urban_aura_flutter/features/orders/presentation/widgets/order_item_card.dart';
import 'package:urban_aura_flutter/features/orders/presentation/widgets/shipping_info_card.dart';

class OrderPage extends StatelessWidget {
  final String _orderId;

  const OrderPage({super.key, required String orderId}) : _orderId = orderId;

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(
          GetOrderByIdActionEvent(orderId: _orderId),
        );
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderActionProcessingState) {
            LoadingDialog()
                .show(context: context, text: 'Cancelling order..');
          }
          if (state is OrderActionFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is OrderActionSuccessState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: CustomScrollView(
          primary: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              stretch: true,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
              title: const Text(
                'Orders',
                style: TextStyle(letterSpacing: 4),
              ),
              stretchTriggerOffset: 100,
              onStretchTrigger: () async {
                context.read<OrderBloc>().add(
                      const GetOrdersEvent(),
                    );
              },
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CustomCircularProgressIndicator()),
                  );
                }
                if (state is OrderLoadedState) {
                  return MultiSliver(children: [
                    OrderInfoCard(
                      orderEntity: state.order,
                    ),
                    ShippingInfoCard(
                      orderEntity: state.order,
                    ),
                    SliverList.separated(
                      itemCount: state.order.orderItems.length,
                      itemBuilder: (context, index) {
                        return OrderItemCard(
                            orderItemEntity: state.order.orderItems[index]);
                      },
                      separatorBuilder: (context, miniIndex) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                    )
                  ]);
                }
                if (state is OrderFailedState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
              buildWhen: (prev, curr) {
                if (curr is OrderLoadedState ||
                    curr is OrderFailedState ||
                    curr is OrderLoadingState) {
                  return true;
                }
                return false;
              },
            )
          ],
        ),
      ),
    );
  }
}
