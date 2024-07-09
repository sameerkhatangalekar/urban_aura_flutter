
import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/config/mock_data.dart';

import '../../../../core/theme/app_palette.dart';

class CartItem extends StatefulWidget {
  final ProductData productData;
  const CartItem({super.key, required this.productData});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
   int itemCount = 0;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                widget.productData .image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.productData.productName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                        letterSpacing: 4,
                        color: AppPalette.titleActive),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.productData.description,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          color: AppPalette.label,
                          wordSpacing: 2)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            itemCount--;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                        ), color: AppPalette.placeHolder,
                        style: ButtonStyle(
                          maximumSize: const WidgetStatePropertyAll(
                              Size(28, 28)),
                          minimumSize: const WidgetStatePropertyAll(
                              Size(28, 28)),
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.zero),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(100),
                              side: const BorderSide(
                                  color: AppPalette.placeHolder,
                                  width: 0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(itemCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                              color: AppPalette.label,
                              wordSpacing: 2)),
                      const SizedBox(
                        height: 4,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            itemCount++;
                          });

                        },
                        color: AppPalette.placeHolder,
                        icon: const Icon(
                          Icons.add,
                        ),
                        style: ButtonStyle(
                          maximumSize: const WidgetStatePropertyAll(
                              Size(28, 28)),
                          minimumSize: const WidgetStatePropertyAll(
                              Size(28, 28)),
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.zero),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(100),
                              side: const BorderSide(
                                  color: AppPalette.placeHolder,
                                  width: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$${widget.productData.price.toStringAsFixed(0)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                        color: AppPalette.secondaryColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
