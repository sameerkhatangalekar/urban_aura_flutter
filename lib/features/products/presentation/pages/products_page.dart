import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: () async => context.read<ProductsBloc>().add(
              const GetProductsEvent(),
            ),
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              showBackButton: true,
            ),
            BlocConsumer<ProductsBloc, ProductsState>(
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
                        return GestureDetector(
                          onTap: () => context.push(
                            '/products/${product.name}',
                            extra: product,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Hero(
                                  tag: product.id,
                                  child: CachedNetworkImage(
                                    imageUrl: product.images[0],
                                    fit: BoxFit.contain,
                                    errorWidget: (context, _, __) => Container(
                                      color: getRandomColor(),
                                      child: const Center(
                                        child: Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    placeholder: (ctx, value) {
                                      return Container(
                                        color: getRandomColor(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${product.name} ${product.description}',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.fontSize,
                                            color: AppPalette.body),
                                      ),
                                      Text(
                                        '\$${product.price}',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppPalette.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
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
              listener: (BuildContext context, ProductsState state) {

              },
            )
          ],
        ),
      ),
    );
  }
}
