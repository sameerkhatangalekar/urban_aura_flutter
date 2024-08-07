import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/search/presentation/bloc/search_bloc.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.all(12),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Brands',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 44,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final facet = state.brands[index];
                    return CheckboxListTile(
                      activeColor: AppPalette.primaryColor,
                      value: facet.isSelected,
                      onChanged: (value) => context
                          .read<SearchBloc>()
                          .add(ToggleBrandActionEvent(brand: facet.item.value)),
                      title: Text(
                        facet.item.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                  childCount: state.brands.length,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.all(12),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Sizes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 44,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final facet = state.sizes[index];
                    return CheckboxListTile(
                      activeColor: AppPalette.primaryColor,
                      value: facet.isSelected,
                      onChanged: (value) => context
                          .read<SearchBloc>()
                          .add(ToggleSizeActionEvent(size: facet.item.value)),
                      title: Text(
                        facet.item.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                  childCount: state.sizes.length,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.all(12),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Colors',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 44,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final facet = state.colors[index];
                    return CheckboxListTile(
                      activeColor: AppPalette.primaryColor,
                      value: facet.isSelected,
                      onChanged: (value) => context
                          .read<SearchBloc>()
                          .add(ToggleColorActionEvent(color: facet.item.value)),
                      title: Text(
                        facet.item.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                  childCount: state.colors.length,
                ),
              ),
               SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverToBoxAdapter(
                  child: TextButton.icon(
                    style: const ButtonStyle(
                        iconColor: WidgetStatePropertyAll<Color>(Colors.white),
                        backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        splashFactory: InkSparkle.splashFactory),
                    onPressed: () {
                      searchPageKey.currentState?.closeEndDrawer();
                      context.read<SearchBloc>().add(const ResetFilterActionEvent());

                    },
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.filter_list_off_outlined),
                    label: const Text(
                      'Reset Filters',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
