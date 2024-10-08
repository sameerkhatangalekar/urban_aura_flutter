import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_state.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/footer.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';
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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(

      bottomNavigationBar: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.width,
          maxWidth: size.width,
          minHeight: 48,
          maxHeight: 48
        ),
        child: TextButton.icon(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppPalette.titleActive),
              padding: WidgetStateProperty.all( EdgeInsets.zero),
            splashFactory: InkRipple.splashFactory,
            shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            overlayColor: WidgetStateProperty.all(Colors.white10)
          ),
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
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartActionLoadingState) {
            LoadingDialog().show(
              context: context,
            );
          }
          if (state is AddToCartActionSuccessState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
          }
          if (state is AddToCartActionFailedState) {
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
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              showBackButton: true,
              refreshCallback: () {},
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
                      '\$${widget.productEntity.price}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppPalette.secondaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.productEntity.colors.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      setState(() {
                                        selectedColorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: selectedColorIndex == index
                                            ? AppPalette.secondaryColor
                                            : Colors.white,
                                          border: Border.all(color: AppPalette.placeHolder, width: 0.5),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        widget.productEntity.colors[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: selectedColorIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )
                                    ),
                                  );

                                }, separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(width: 4,);
                            },),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
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
              child: SpacerBox(
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
