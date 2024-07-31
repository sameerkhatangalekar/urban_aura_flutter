import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';


import '../../../../core/config/mock_data.dart';
import '../../../../core/theme/app_palette.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: size.height * 0.12,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$240',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        color: AppPalette.secondaryColor),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              color: AppPalette.titleActive,
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    _showSuccessDialog(context: context);
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/shopping_bag_icon.svg',
                    theme: const SvgTheme(
                      currentColor: Colors.white,
                    ),
                  ),
                  label: const Text(
                    'PLACE ORDER',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close)),
              title: const Text(
                'CHECKOUT',
                style: TextStyle(letterSpacing: 4),
              )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            sliver: SliverToBoxAdapter(
              child: Text(
                'SHIPPING ADDRESS',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(letterSpacing: 1, color: AppPalette.placeHolder),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList.separated(
                itemCount: mockAddresses.length,
                itemBuilder: (context, index) {
                  final address = mockAddresses[index];
                  return Container(
                    decoration: const BoxDecoration(color: Colors.white54),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          address.addressLineOne,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppPalette.label),
                        ),
                        Text(
                          address.addressLineTwo,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppPalette.label),
                        ),
                        Text(
                          address.contact,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppPalette.label),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, miniIndex) {
                  return const SizedBox(
                    height: 8,
                  );
                }),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        final screenSize = MediaQuery.sizeOf(context);
        return AlertDialog(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.all(24),
            title: Center(
              child: Text(
                'PAYMENT SUCCESS',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(letterSpacing: 4, fontWeight: FontWeight.w600),
              ),
            ),
            content: SizedBox(
              width: screenSize.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/success_icon.svg',
                  ),
                  const SpacerBox(),
                  Text(
                    'Your payment was success',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(letterSpacing: 2),
                  ),
                  Text(
                    'Payment ID : 15248464',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(letterSpacing: 2),
                  ),
                  const CustomDivider(),
                  const SpacerBox(),
                  TextButton(
                    onPressed: () {

                    context.go('/');
                    },
                    style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.black26)))),
                    child: Text(
                      'BACK TO HOME',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(letterSpacing: 2),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
