import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/address_card.dart';
import 'package:urban_aura_flutter/features/checkout/presentation/bloc/checkout_bloc.dart';
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
      bottomNavigationBar: CustomBlackButton(
          label: 'PLACE ORDER',
          voidCallback: () async {
            if (selectedAddressIndex < 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select address'),
                ),
              );
              return;
            }
            _initiateCheckout();
          }),
      body: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutLoadingState) {
            LoadingDialog()
                .show(context: context, text: 'Initiating checkout...');
          }
          if (state is CheckoutRequestSuccessState) {
            LoadingDialog().hide();
          }

          if (state is CheckoutRequestFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is CheckoutRequestSuccessState) {
            LoadingDialog().hide();
          }

          if (state is InitiatePaymentSheetFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is ShowPaymentSheetFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is PaymentConfirmedState) {
            LoadingDialog().hide();
            _showSuccessDialog(context: context);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close)),
              title: const Text(
                'CHECKOUT',
                style: TextStyle(letterSpacing: 4),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'SHIPPING ADDRESS',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 1, color: AppPalette.placeHolder),
                ),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
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
              },
            )
          ],
        ),
      ),
    );
  }

  void _initiateCheckout() {
    final userBlocState =
        context.read<UserBloc>().state as UserAddressLoadedState;

    context.read<CheckoutBloc>().add(CheckoutRequestedActionEvent(
        name: userBlocState.addresses[selectedAddressIndex].name,
        city: userBlocState.addresses[selectedAddressIndex].city,
        state: userBlocState.addresses[selectedAddressIndex].state,
        country: userBlocState.addresses[selectedAddressIndex].country,
        contact: userBlocState.addresses[selectedAddressIndex].contact,
        line_one: userBlocState.addresses[selectedAddressIndex].line_one,
        postal_code:
            userBlocState.addresses[selectedAddressIndex].postal_code));
  }

  void _showSuccessDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
