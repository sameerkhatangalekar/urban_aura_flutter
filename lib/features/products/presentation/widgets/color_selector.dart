import 'package:flutter/material.dart';

import '../../../../core/helper/color_provider.dart';
import '../../../../core/theme/app_palette.dart';

class ColorSelector extends StatefulWidget {
  final List<String> colors;
  const ColorSelector({super.key, required this.colors});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    debugPrint('colors rendered');
    return Row(children: [
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
        height: 22,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.colors.length,
            itemBuilder: (context, index) {
              return InkWell(
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
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: getRandomColor(),
                        borderRadius:
                        BorderRadius.circular(100)),
                  ),
                ),
              );
            }),
      ),

    ],);
  }
}
