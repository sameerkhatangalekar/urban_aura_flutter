import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/diamond_indicator.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';

class ImageSlider extends StatefulWidget {
  final String productId;
  final List<String> images;

  const ImageSlider({super.key, required this.images, required this.productId});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Hero(
          tag: widget.productId,
          child: CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return CachedNetworkImage(
                imageUrl: widget.images[index],
                width: size.width,
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
                placeholder: (context, value) => Container(
                  color: getRandomColor(),
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (newIndex, reason) {
                setState(() {
                  currentImageIndex = newIndex;
                });
              },
              autoPlay: false,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              height: size.height * 0.6,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 8,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DiamondIndicator(
                isActive: currentImageIndex == index,
              );
            },
            itemCount: widget.images.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        )
      ],
    );
  }
}
