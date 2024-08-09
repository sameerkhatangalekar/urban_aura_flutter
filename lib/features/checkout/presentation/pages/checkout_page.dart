import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/address_card.dart';
import 'package:urban_aura_flutter/features/user/presentation/widgets/custom_black_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedAddressIndex = -1;

  @override
  void initState() {
    context.read<UserBloc>().add(
      const GetAddressesEvent(),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBlackButton(
        label: 'PLACE ORDER',
        voidCallback: () => _showSuccessDialog(context: context),
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
          BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserAddressLoadingState) {
              return const SliverToBoxAdapter(
                child: Center(child: CustomCircularProgressIndicator()),
              );
            }

            if (state is UserAddressLoadedState) {
              if (state.addresses.isEmpty) {
                return const SliverToBoxAdapter(
                    child: Center(child: Text('No addresses added')));
              }
              return SliverList.separated(
                itemCount: state.addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  final address = state.addresses[index];
                  return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        setState(() {
                          selectedAddressIndex = index;
                        });
                      },
                      child: AddressCard(
                        addressEntity: address,
                        isSelected: index == selectedAddressIndex,
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 4,
                  );
                },
              );
            }

            if (state is UserAddressFailedState) {
              return SliverToBoxAdapter(
                child: Center(
                  child: IconButton(
                    onPressed: () => context.read<UserBloc>().add(
                          const GetAddressesEvent(),
                        ),
                    icon: const Icon(CupertinoIcons.refresh),
                  ),
                ),
              );
            }

            return const SliverToBoxAdapter();
          })
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

