import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/address_card.dart';
import 'package:urban_aura_flutter/features/user/presentation/widgets/address_form.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(const GetAddressesEvent());
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserActionLoadingState) {
              LoadingDialog().show(context: context, text: state.message);
            }
            if (state is UserActionSuccessState) {
              LoadingDialog().hide();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
            }
            if (state is UserActionFailedState) {
              LoadingDialog().hide();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
            }
          },
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              CustomSliverAppBar(
                refreshCallback: () =>
                    context.read<UserBloc>().add(const GetAddressesEvent()),
                showBackButton: true,
              ),
              const SliverToBoxAdapter(
                child: Center(child: Text('Addresses')),
              ),
              const SliverToBoxAdapter(
                child: CustomDivider(),
              ),
              SliverToBoxAdapter(
                  child: Center(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          enableDrag: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => const AddressForm(),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero));
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade100),
                    ),
                    icon: const Icon(
                      CupertinoIcons.add,
                      color: Colors.black54,
                    ),
                    label: const Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              )),
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
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    sliver: SliverList.separated(
                      itemCount: state.addresses.length,
                      itemBuilder: (BuildContext context, int index) {
                        final address = state.addresses[index];
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            AddressCard(addressEntity: address),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () => showModalBottomSheet(
                                        enableDrag: true,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (ctx) => AddressForm(
                                              addressEntity: address,
                                            ),
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.grey.shade600,
                                    )),
                                IconButton(
                                    onPressed: () => context
                                        .read<UserBloc>()
                                        .add(DeleteAddressActionEvent(
                                            addressId: address.id)),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade600,
                                    )),
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                    ),
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
        ));
  }
}
