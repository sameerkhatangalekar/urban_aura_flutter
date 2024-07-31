import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:urban_aura_flutter/features/cart/presentation/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          if (state is CartSuccessState) {
            return SizedBox(
              height: size.height * 0.25,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SUB TOTAL',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '\$${state.cartEntity.cartTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              color: AppPalette.secondaryColor),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '*shipping charges, taxes and discount codes are calculated at the time of accounting',
                      maxLines: 2,
                      style: TextStyle(color: AppPalette.placeHolder),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    color: AppPalette.titleActive,
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {
                          context.push('/checkout');
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/shopping_bag_icon.svg',
                          theme: const SvgTheme(
                            currentColor: Colors.white,
                          ),
                        ),
                        label: const Text(
                          'BUY NOW',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return SizedBox(
            height: size.height * 0.25,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUB TOTAL',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '\$--',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            color: AppPalette.secondaryColor),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '*shipping charges, taxes and discount codes are calculated at the time of accounting',
                    maxLines: 2,
                    style: TextStyle(color: AppPalette.placeHolder),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(4),
                  color: AppPalette.titleActive,
                  child: Center(
                    child: TextButton.icon(
                      onPressed: () {
                        context.push('/checkout');
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/shopping_bag_icon.svg',
                        theme: const SvgTheme(
                          currentColor: Colors.white,
                        ),
                      ),
                      label: const Text(
                        'BUY NOW',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(
                onPressed: () => context.pop(), icon: const Icon(Icons.close)),
            title: const Text(
              'CART',
              style: TextStyle(letterSpacing: 4),
            ),
          ),
          BlocConsumer<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return const CircularProgressIndicator(
                  strokeWidth: 1,
                  strokeCap: StrokeCap.round,
                  color: AppPalette.primaryColor,
                );
              }
              if (state is CartSuccessState) {
                return SliverList.separated(
                    itemCount: state.cartEntity.cart.isEmpty
                        ? 1
                        : state.cartEntity.cart.length,
                    itemBuilder: (context, index) {
                      if (state.cartEntity.cart.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text('Cart is empty'),
                          ),
                        );
                      }

                      return CartItemCard(
                        cartItem: state.cartEntity.cart[index],
                      );
                    },
                    separatorBuilder: (context, miniIndex) {
                      return const SizedBox(
                        height: 4,
                      );
                    });
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is CartActionLoadingState) {
                LoadingDialog().show(context: context,);
              }

              if (state is IncrementItemCountActionSuccessState) {
                LoadingDialog().hide();

              }
              if (state is DecrementItemCountActionSuccessState) {
                LoadingDialog().hide();
              }

              if (state is IncrementItemCountActionFailedState ) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is DecrementItemCountActionFailedState ) {
                LoadingDialog().hide();
                ScaffoldMessenger.of(context).showSnackBar(
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
