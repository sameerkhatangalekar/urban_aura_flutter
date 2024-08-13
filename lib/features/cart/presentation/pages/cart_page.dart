import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_state.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_summery_sheet.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(
          const GetCartEvent(),
        );
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: const CartSummarySheet(),
      body: CustomScrollView(
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
              'CART',
              style: TextStyle(letterSpacing: 4),
            ),
            stretchTriggerOffset: 100,
            onStretchTrigger: () async {
              context.read<CartBloc>().add(
                    const GetCartEvent(),
                  );
            },
          ),
          BlocConsumer<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(28),
                    child: Center(child: CustomCircularProgressIndicator()),
                  ),
                );
              }
              if (state is CartSuccessState) {
                if (state.cartEntity.cart.isEmpty) {
                  return SliverToBoxAdapter(
                      child: Column(
                    children: [
                      const Center(
                        child: Text('Cart is empty'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
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
                  itemCount: state.cartEntity.cart.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      cartItem: state.cartEntity.cart[index],
                    );
                  },
                  separatorBuilder: (context, miniIndex) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                );
              }
              if (state is CartFailedState) {
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
              if (curr is CartLoadingState ||
                  curr is CartSuccessState ||
                  curr is CartFailedState) {
                return true;
              }

              return false;
            },
            listener: (context, state) {
              if (state is CartFailedState) {
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is CartActionLoadingState) {
                LoadingDialog().show(
                  context: context,
                );
              }
              if (state is RemoveFromCartActionSuccessState) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
              }
              if (state is RemoveFromCartActionFailedState) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
              }

              if (state is IncrementItemCountActionSuccessState) {
                LoadingDialog().hide();
              }
              if (state is DecrementItemCountActionSuccessState) {
                LoadingDialog().hide();
              }

              if (state is IncrementItemCountActionFailedState) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
              }
              if (state is DecrementItemCountActionFailedState) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
              }
            },
          )
        ],
      ),
    );
  }
}
