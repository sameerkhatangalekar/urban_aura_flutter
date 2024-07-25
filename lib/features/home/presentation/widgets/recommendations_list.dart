import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/widgets/custom_divider.dart';
import '../../../../core/common/widgets/spacer_box.dart';
import '../../../../core/config/mock_data.dart';
import '../../../../core/theme/app_palette.dart';

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
        CarouselSlider.builder(
          itemCount: homePageProducts.length,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Image.network(
                      homePageProducts[itemIndex].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              '${homePageProducts[itemIndex].productName} ${homePageProducts[itemIndex].description}',
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
                              '\$${homePageProducts[itemIndex].price.toStringAsFixed(0)}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppPalette.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            );
          },
          options: CarouselOptions(
              onPageChanged: (pageIndex, reason) {
                setState(() {
                  activeItem = pageIndex;
                });
              },
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
        // Container(
        //   constraints: BoxConstraints(
        //     maxHeight: 8,
        //     minHeight: 8,
        //     maxWidth: size.width * 0.4,
        //     minWidth: size.width * 0.4,
        //   ),
        //   child: Center(
        //     child: ListView.separated(
        //       shrinkWrap: true,
        //       scrollDirection: Axis.horizontal,
        //       itemCount: homePageProducts.length,
        //       itemBuilder: (context, index) {
        //         return DiamondIndicator(
        //           isActive: index == activeItem,
        //         );
        //       },
        //       separatorBuilder: (BuildContext context, int index) {
        //         return const SizedBox(
        //           width: 8,
        //         );
        //       },
        //     ),
        //   ),
        // )
      ],
    );
  }
}
