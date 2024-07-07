
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/mock_data.dart';
import '../../../../core/common/widgets/spacer_box.dart';
import '../../../../core/theme/app_palette.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(children: [
      Center(
        child: Text(
          'JUST FOR YOU',
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
      CarouselSlider.builder(
        itemCount: homePageProducts.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  homePageProducts[itemIndex].image,
                  fit: BoxFit.contain,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        homePageProducts[itemIndex].productName,
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
                        '\$${homePageProducts[itemIndex].price.toStringAsFixed(0)}',
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
            ),
          );
        },
        options: CarouselOptions(
            autoPlay: false,
            height: 350,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 0.6,
            initialPage: 0,
            aspectRatio: 1.0),
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: pi / 4,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: AppPalette.label, width: 0.6)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Transform.rotate(
            angle: pi / 4,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: AppPalette.label, width: 0.6)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Transform.rotate(
            angle: pi / 4,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: AppPalette.label, width: 0.6)),
            ),
          )
        ],
      ),
    ],);
  }
}
