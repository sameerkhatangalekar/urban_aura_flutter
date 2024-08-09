import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(
            showBackButton: true,
            refreshCallback: () =>
                context.read<ProductsBloc>().add(const GetProductsEvent()),
          ),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductListLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is ProductListLoadedState) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 0.5),
                    itemCount:
                        state.products.isEmpty ? 1 : state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }

                      final product = state.products[index];
                      return ProductCard(product: product);
                    },
                  ),
                );
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
          )
        ],
      ),
    );
  }
}
