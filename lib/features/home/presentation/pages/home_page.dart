import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_aura_flutter/core/common/bloc/app_user_cubit.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/footer.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/home/presentation/widgets/recommendations_list.dart';
import 'package:urban_aura_flutter/features/products/presentation/bloc/products_bloc.dart';
import 'package:vector_graphics/vector_graphics.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        drawer:  Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  tileColor: Colors.white,
                  trailing: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    context.read<AppUserCubit>().logout();
                  },
                ),
              )
            ],
          ),
        ),

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: ()=> context.push('/products'),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                        margin: EdgeInsets.zero,
                        height: size.height * 0.75,
                        width: size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/home_banner.jpg',
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 42),
                              child: Text(
                                'LUXURY',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.bodoniModa(
                                    fontSize: 38,
                                    fontStyle: FontStyle.italic,
                                    color: AppPalette.body,
                                    letterSpacing: 1.21),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Text(
                                'FASHION',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.bodoniModa(
                                    fontSize: 38,
                                    fontStyle: FontStyle.italic,
                                    color: AppPalette.body,
                                    letterSpacing: 1.21),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 42),
                              child: Text(
                                '& ACCESSORIES',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.bodoniModa(
                                    fontSize: 38,
                                    fontStyle: FontStyle.italic,
                                    color: AppPalette.body,
                                    letterSpacing: 1.21),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 60,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Colors.black45,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 8),
                            child: const Center(
                              child: Text(
                                'EXPLORE COLLECTION',
                                style: TextStyle(
                                    fontSize: 16, color: AppPalette.offWhite),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),
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
              child: SpacerBox(),
            ),
            //TODO : replace with dynamic data with sliver horizontal list
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        letterSpacing: 1,
                        color: AppPalette.titleActive),
                  ),
                  Text(
                    'Apparel',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        letterSpacing: 1,
                        color: AppPalette.placeHolder),
                  ),
                  Text(
                    'Dress',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        letterSpacing: 1,
                        color: AppPalette.placeHolder),
                  ),
                  Text(
                    'Tshirt',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        letterSpacing: 1,
                        color: AppPalette.placeHolder),
                  ),
                  Text(
                    'Bag',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        letterSpacing: 1,
                        color: AppPalette.placeHolder),
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),

            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductListLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        strokeCap: StrokeCap.round,
                        color: AppPalette.primaryColor,
                      ),
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
                      state.products.isEmpty ? 1 : min(4, state.products.length),
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
            ),
            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),
            SliverToBoxAdapter(
              child: TextButton.icon(
                style: const ButtonStyle(
                  enableFeedback: false,
                  iconColor: WidgetStatePropertyAll(AppPalette.titleActive),
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  context.push('/products');
                },
                iconAlignment: IconAlignment.end,
                label: Text(
                  'Explore More',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: AppPalette.titleActive),
                ),
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: CustomDivider(),
            ),

            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),

            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'COLLECTIONS',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      letterSpacing: 4,
                      color: AppPalette.titleActive),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: Image.asset('assets/images/october_collection.jpg'),
            ),

            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),
            SliverToBoxAdapter(
              child: Image.asset(
                'assets/images/autumn_collection.jpg',
                fit: BoxFit.scaleDown,
                width: 260,
                height: 296,
              ),
            ),
            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),

            const SliverToBoxAdapter(
              child: RecommendationsList(),
            ),
            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),

            SliverToBoxAdapter(
              child: Container(
                color: AppPalette.cardBackground,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      width: 100,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: Text(
                        'Making a luxurious lifestyle accessible for a generous group of women is our daily drive',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPalette.label,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const CustomDivider(),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VectorGraphic(
                                loader: AssetBytesLoader(
                                    'assets/icons/fast_shipping.svg.vec'),
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Best discounts across all styles.',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.label,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VectorGraphic(
                                loader: AssetBytesLoader(
                                    'assets/icons/sustainable.svg.vec'),
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Sustainable process from start to finish.',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.label,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VectorGraphic(
                                loader: AssetBytesLoader(
                                    'assets/icons/unique_style.svg.vec'),
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Unique designs\nand high-quality materials.',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.label,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VectorGraphic(
                                loader: AssetBytesLoader(
                                    'assets/icons/free_shipping.svg.vec'),
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                'Fast shipping. Free on orders over \$25.',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppPalette.label,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SpacerBox(),
            ),
            const SliverToBoxAdapter(
              child: Footer(),
            )
          ],
        ));
  }
}
