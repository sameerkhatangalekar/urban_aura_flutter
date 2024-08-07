import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/product_card.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/features/search/presentation/bloc/search_bloc.dart';
import 'package:urban_aura_flutter/features/search/presentation/widget/filter_button.dart';
import 'package:urban_aura_flutter/features/search/presentation/widget/filter_drawer.dart';
import 'package:urban_aura_flutter/init_dependencies.main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    serviceLocator<SearchBloc>()
      ..add(
        const ProductSubscriptionRequestedEvent(),
      )
      ..add(
        const BrandsSubscriptionRequestedEvent(),
      )
      ..add(
        const SizeSubscriptionRequestedEvent(),
      )
      ..add(
        const ColorSubscriptionRequestedEvent(),
      )
      ..add(
        const AppliedFilterCountSubscriptionRequestedEvent(),
      );

    return Scaffold(
      key: searchPageKey,
      endDrawer: const FilterDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: 28,
            leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back)),
            title: SearchBar(
              backgroundColor:
                  WidgetStatePropertyAll<Color>(Colors.grey.shade100),
              hintText: 'Search...',
              controller: _searchController,
              onChanged: (query) => context
                  .read<SearchBloc>()
                  .add(SearchActionEvent(query: query)),
              trailing: [
                IconButton(
                    onPressed: () {
                      _searchController.clear();
                      context
                          .read<SearchBloc>()
                          .add(const SearchActionEvent(query: ''));
                    },
                    icon: const Icon(Icons.close))
              ],
              hintStyle: WidgetStatePropertyAll(
                Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey),
              ),
              constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
            ),
            actions: const [
              FilterButton(),
              SizedBox(
                width: 4,
              )
            ],
          ),
          BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state.searchStatus == SearchStatus.productsLoading) {
              return SliverFillViewport(
                delegate: SliverChildListDelegate([
                  const Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                ]),
              );
            }
            if (state.searchStatus == SearchStatus.productsSuccess) {
              if (state.products.isEmpty) {
                return SliverFillViewport(
                  delegate: SliverChildListDelegate([
                    const Center(
                      child: Text('No products found'),
                    ),
                  ]),
                );
              }
              return SliverGrid.builder(
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                  );
                },
              );
            }

            if (state.searchStatus == SearchStatus.productsFailure) {
              return const SliverToBoxAdapter(
                  child: Center(
                child: Text('Something went wrong..'),
              ));
            }

            return const SliverToBoxAdapter();
          })
        ],
      ),
    );
  }
}
