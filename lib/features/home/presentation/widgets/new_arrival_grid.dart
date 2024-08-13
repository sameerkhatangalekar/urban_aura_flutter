import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/product_card.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';

class NewArrivalGrid extends StatelessWidget {
  const NewArrivalGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductListLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(child: CustomCircularProgressIndicator()),
          );
        }
        if (state is ProductListLoadedState) {
          return MultiSliver(children: [
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'NEW ARRIVAL',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      letterSpacing: 4,
                      color: AppPalette.titleActive),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomDivider(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5),
                itemCount:
                    state.products.isEmpty ? 1 : min(4, state.products.length),
                itemBuilder: (BuildContext context, int index) {
                  if (state.products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                  );
                },
              ),
            )
          ]);
        }

        if (state is ProductListFailedState) {
          return SliverToBoxAdapter(
            child: Center(
              child: IconButton(
                onPressed: () => context.read<ProductsBloc>().add(
                      const GetProductsEvent(),
                    ),
                icon: const Icon(CupertinoIcons.refresh),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter();
      },
    );
  }
}
