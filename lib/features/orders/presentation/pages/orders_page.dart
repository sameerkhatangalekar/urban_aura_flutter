import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/features/orders/presentation/bloc/order_bloc.dart';
import 'package:urban_aura_flutter/features/orders/presentation/widgets/order_overview_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(
          const GetOrdersEvent(),
        );
    return Scaffold(
      body: CustomScrollView(
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
              if (state is OrdersLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(child: CustomCircularProgressIndicator()),
                );
              }
              if (state is OrdersLoadedState) {
                if (state.orders.isEmpty) {
                  return SliverToBoxAdapter(
                      child: Column(
                    children: [
                      const Center(
                        child: Text('There are no orders'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushReplacement('/products');
                        },
                        style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.black26)))),
                        child: Text(
                          'START SHOPPING',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(letterSpacing: 2),
                        ),
                      )
                    ],
                  ));
                }

                return SliverList.separated(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return OrderOverViewCard(orderEntity: state.orders[index]);
                  },
                  separatorBuilder: (context, miniIndex) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                );
              }
              if (state is OrdersFailedState) {
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
              if (curr is OrdersLoadingState ||
                  curr is OrdersLoadedState ||
                  curr is OrdersFailedState) {
                return true;
              }

              return false;
            },
          )
        ],
      ),
    );
  }
}
