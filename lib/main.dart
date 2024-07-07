import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_aura_flutter/config/mock_data.dart';
import 'package:urban_aura_flutter/core/common/widgets/footer.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/home/presentation/widgets/recommendations_list.dart';

import 'core/common/widgets/spacer_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                leading: InkWell(
                  onTap: () {},
                  splashColor: Colors.grey.shade300,
                  child: SvgPicture.asset(
                    'assets/icons/menu_icon.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                title: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 78,
                    maxWidth: 78,
                    minHeight: 32,
                    maxHeight: 32,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/logo.svg',
                    color: AppPalette.titleActive,
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.grey.shade300,
                    child: SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.grey.shade300,
                    child: SvgPicture.asset(
                      'assets/icons/shopping_bag_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
                centerTitle: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Stack(
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
                                child: Center(
                                  child: Text(
                                    'EXPLORE COLLECTION',
                                    style: GoogleFonts.tenorSans(
                                        fontSize: 16,
                                        color: AppPalette.offWhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SpacerBox(),
                    Center(
                      child: Text(
                        'NEW ARRIVAL',
                        style: GoogleFonts.tenorSans(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize,
                            letterSpacing: 4,
                            color: AppPalette.titleActive),
                      ),
                    ),

                    ///DIVIDER
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                            indent: size.width * 0.3,
                            endIndent: size.width * 0.3,
                            thickness: 0.5,
                            color: AppPalette.label),
                        Transform.rotate(
                          angle: pi / 4,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppPalette.label, width: 0.6)),
                          ),
                        )
                      ],
                    ),
                    const SpacerBox(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'All',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              letterSpacing: 1,
                              color: AppPalette.titleActive),
                        ),
                        Text(
                          'Apparel',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              letterSpacing: 1,
                              color: AppPalette.placeHolder),
                        ),
                        Text(
                          'Dress',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              letterSpacing: 1,
                              color: AppPalette.placeHolder),
                        ),
                        Text(
                          'Tshirt',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              letterSpacing: 1,
                              color: AppPalette.placeHolder),
                        ),
                        Text(
                          'Bag',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              letterSpacing: 1,
                              color: AppPalette.placeHolder),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 2,
                              childAspectRatio: 0.62),
                      shrinkWrap: true,
                      itemCount: homePageProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              homePageProducts[index].image,
                              fit: BoxFit.contain,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    homePageProducts[index].productName,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.tenorSans(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.fontSize,
                                        color: AppPalette.body),
                                  ),
                                  Text(
                                    '\$${homePageProducts[index].price.toStringAsFixed(0)}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.tenorSans(
                                      fontSize: 16,
                                      color: AppPalette.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    const SpacerBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Explore More',
                          style: GoogleFonts.tenorSans(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                              color: AppPalette.titleActive),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.grey.shade300,
                          child: SvgPicture.asset(
                            'assets/icons/forward_arrow_icon.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),

                    ///DIVIDER
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                            indent: size.width * 0.3,
                            endIndent: size.width * 0.3,
                            thickness: 0.5,
                            color: AppPalette.label),
                        Transform.rotate(
                          angle: pi / 4,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppPalette.label, width: 0.6)),
                          ),
                        )
                      ],
                    ),
                    const SpacerBox(),

                    ///Section
                    Center(
                      child: Text(
                        'COLLECTIONS',
                        style: GoogleFonts.tenorSans(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize,
                            letterSpacing: 4,
                            color: AppPalette.titleActive),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset('assets/images/october_collection.jpg'),
                    const SpacerBox(),
                    Image.asset(
                      'assets/images/autumn_collection.jpg',
                      fit: BoxFit.scaleDown,
                      width: 260,
                      height: 296,
                    ),
                    const SpacerBox(),

                    ///Section
                    const RecommendationsList(),
                    const SpacerBox(),

                    ///Section
                    Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Text(
                              'Making a luxurious lifestyle accessible for a generous group of women is our daily drive',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tenorSans(
                                color: AppPalette.label,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Divider(
                                  indent: size.width * 0.3,
                                  endIndent: size.width * 0.3,
                                  thickness: 0.5,
                                  color: AppPalette.label),
                              Transform.rotate(
                                angle: pi / 4,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppPalette.label, width: 0.6)),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/fast_shipping.svg',
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      'Best discounts across all styles.',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tenorSans(
                                        color: AppPalette.label,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/sustainable.svg',
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      'Sustainable process from start to finish.',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tenorSans(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/unique_style.svg',
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      'Unique designs\nand high-quality materials.',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tenorSans(
                                        color: AppPalette.label,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/sustainable.svg',
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      'Fast shipping. Free on orders over \$25.',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tenorSans(
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

                    const SpacerBox(),

                    ///Section
                    const Footer()
                  ],
                ),
              )
            ],
          )),
    );
  }
}
