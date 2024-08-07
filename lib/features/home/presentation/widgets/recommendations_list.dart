import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/product_card.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';

class RecommendationsList extends StatefulWidget {
  const RecommendationsList({super.key});

  @override
  State<RecommendationsList> createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {
  int activeItem = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'JUST FOR YOU',
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                letterSpacing: 4,
                color: AppPalette.titleActive),
          ),
        ),
        const CustomDivider(),
        const SpacerBox(),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductListLoadingState) {
              return const SliverToBoxAdapter(
                child: Center(child: CustomCircularProgressIndicator()),
              );
            }
            if (state is ProductListLoadedState) {
              ///This is done to avoid same hero tags and should be removed as soon as algolia recommendation is plugged in
              //TODO plug algolia recommendation model
              final products = state.products.skip(4).toList();
              return CarouselSlider.builder(
                itemCount: state.products.isEmpty ? 1 : min(4, products.length),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return ProductCard(product: products[itemIndex]);
                },
                options: CarouselOptions(
                    onPageChanged: (pageIndex, reason) {
                      setState(() {
                        activeItem = pageIndex;
                      });
                    },
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    viewportFraction: 0.6,
                    initialPage: 0,
                    aspectRatio: 1.0),
              );
            }

            if (state is ProductListFailedState) {
              return Center(
                child: IconButton(
                  onPressed: () => context.read<ProductsBloc>().add(
                        const GetProductsEvent(),
                      ),
                  icon: const Icon(CupertinoIcons.refresh),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
