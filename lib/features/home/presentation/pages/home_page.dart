import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../../../core/common/widgets/custom_divider.dart';
import '../../../../core/common/widgets/custom_sliver_app_bar.dart';
import '../../../../core/common/widgets/footer.dart';
import '../../../../core/common/widgets/spacer_box.dart';
import '../../../../core/config/mock_data.dart';
import '../../../../core/theme/app_palette.dart';
import '../widgets/recommendations_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            SliverToBoxAdapter(
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

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.62),
                itemCount: homePageProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = homePageProducts[index];
                  return GestureDetector(
                    onTap: () => context.push(
                        '/products/${product.productName}',
                        extra: product),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: product.image,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '${product.productName} ${product.description}',
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
                                '\$${product.price.toStringAsFixed(0)}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppPalette.primaryColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
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
                onPressed: () {},
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
