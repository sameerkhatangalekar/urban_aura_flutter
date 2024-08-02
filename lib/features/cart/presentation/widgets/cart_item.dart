import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/helper/color_provider.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/cart_entity.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';

import '../../../../core/theme/app_palette.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int itemCount;

  @override
  void initState() {
    itemCount = widget.cartItem.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        constraints: BoxConstraints(
          maxHeight: size.height * 0.2,
          minHeight: size.height * 0.2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: CachedNetworkImage(
                imageUrl: widget.cartItem.product.images.first,
                fit: BoxFit.contain,
                placeholder: (context, _) => Container(
                  color: getRandomColor(),
                ),
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
                    widget.cartItem.product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 4, color: AppPalette.titleActive),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.cartItem.product.brand,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppPalette.label, wordSpacing: 2)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              if (itemCount > 1) {
                                itemCount--;
                                context.read<CartBloc>().add(
                                      DecrementItemCountAction(
                                          cartItemId: widget.cartItem.id,
                                          quantity: itemCount),
                                    );
                              }
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                        color: AppPalette.placeHolder,
                        style: ButtonStyle(
                          iconSize: const WidgetStatePropertyAll(16),
                          maximumSize:
                              const WidgetStatePropertyAll(Size(20, 20)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size(20, 20)),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: const BorderSide(
                                  color: Colors.black26, width: 0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(itemCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPalette.label, wordSpacing: 2)),
                      const SizedBox(
                        width: 12,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            itemCount++;
                            context.read<CartBloc>().add(
                                  IncrementItemCountAction(
                                      cartItemId: widget.cartItem.id,
                                      quantity: itemCount),
                                );
                          });
                        },
                        color: AppPalette.placeHolder,
                        icon: const Icon(
                          Icons.add,
                        ),
                        style: ButtonStyle(
                          iconSize: const WidgetStatePropertyAll(16),
                          maximumSize:
                              const WidgetStatePropertyAll(Size(20, 20)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size(20, 20)),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: const BorderSide(
                                  color: Colors.black26, width: 0.5),
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
                    '\$${widget.cartItem.product.price.toStringAsFixed(0)} x $itemCount',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppPalette.secondaryColor),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
