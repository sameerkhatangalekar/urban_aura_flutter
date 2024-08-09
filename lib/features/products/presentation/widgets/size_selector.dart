import 'package:flutter/material.dart';

import '../../../../core/theme/app_palette.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;

  const SizeSelector({super.key, required this.sizes});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSizeIndex = -1;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text('Sizes : ',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppPalette.label, wordSpacing: 2)),
        const SizedBox(
          width: 4,
        ),
        SizedBox(
          height: 24,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.sizes.length,
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
                            color: AppPalette.placeHolder, width: 0.5),
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        widget.sizes[index],
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
    );
  }
}
