import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_state.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/footer.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';
import 'package:urban_aura_flutter/features/products/presentation/widgets/image_slider.dart';

class ProductPage extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductPage({super.key, required this.productEntity});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedSizeIndex = -1;
  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(4),
        color: AppPalette.titleActive,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                if (selectedSizeIndex < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select size'),
                    ),
                  );
                  return;
                }
                if (selectedColorIndex < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select color'),
                    ),
                  );
                  return;
                }

                context.read<CartBloc>().add(
                      AddToCartAction(
                        productId: widget.productEntity.id,
                        color: widget.productEntity.colors[selectedColorIndex],
                        size: widget.productEntity.sizes[selectedSizeIndex],
                      ),
                    );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'ADD TO BASKET',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state is CartActionLoadingState) {
            LoadingDialog().show(
              context: context,
            );
          }
          if (state is AddToCartActionSuccessState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is AddToCartActionFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              showBackButton: true,
            ),
            SliverPadding(
              sliver: SliverToBoxAdapter(
                  child: ImageSlider(
                images: widget.productEntity.images,
                productId: widget.productEntity.id,
              )),
              padding: const EdgeInsets.only(
                top: 8,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.productEntity.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          letterSpacing: 4, color: AppPalette.titleActive),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.productEntity.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppPalette.label,
                            wordSpacing: 2,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '\$${widget.productEntity.price.toStringAsFixed(0)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppPalette.secondaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('Colors : ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPalette.label, wordSpacing: 2)),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 22,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.productEntity.colors.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColorIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppPalette.placeHolder,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                          color: hexToColor(colorMap[widget
                                              .productEntity.colors[index]
                                              .toLowerCase()]!),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text('Sizes : ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPalette.label, wordSpacing: 2)),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          height: 24,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.productEntity.sizes.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                    setState(() {
                                      selectedSizeIndex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    constraints: const BoxConstraints(
                                        minWidth: 24,
                                        maxWidth: 24,
                                        minHeight: 24,
                                        maxHeight: 24),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                        color: selectedSizeIndex == index
                                            ? AppPalette.secondaryColor
                                            : Colors.white,
                                        border: Border.all(
                                            color: AppPalette.placeHolder,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        widget.productEntity.sizes[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: selectedSizeIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //TODO FILL RELATIVE PRODUCT DATA
           const SliverToBoxAdapter(
             child:  SpacerBox(
               height: 200,
             ),
           ),
            const SliverToBoxAdapter(
              child: Footer(),
            )
          ],
        ),
      ),
    );
  }
}
