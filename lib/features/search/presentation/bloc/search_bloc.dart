import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/bloc/cart/cart_bloc.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';
import 'package:urban_aura_flutter/features/search/domain/repository/search_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc({
    required SearchRepository searchRepository,
  })  : _searchRepository = searchRepository,
        super(const SearchState()) {
    on<ProductSubscriptionRequestedEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            searchStatus: SearchStatus.productsLoading,
          ),
        );

        await emit.forEach(
          _searchRepository.products,
          onData: (products) => state.copyWith(
              searchStatus: SearchStatus.productsSuccess, products: products),
        );
      },
    );

    on<BrandsSubscriptionRequestedEvent>((event, emit) async {
      await emit.forEach(
        _searchRepository.brandFacet,
        onData: (brands) => state.copyWith(brands: brands),
      );
    });
    on<SizeSubscriptionRequestedEvent>((event, emit) async {
      await emit.forEach(
        _searchRepository.sizeFacet,
        onData: (sizes) => state.copyWith(sizes: sizes),
      );
    });

    on<ColorSubscriptionRequestedEvent>((event, emit) async {
      await emit.forEach(
        _searchRepository.colorFacet,
        onData: (colors) => state.copyWith(colors: colors),
      );
    });

    on<AppliedFilterCountSubscriptionRequestedEvent>((event, emit) async {
      await emit.forEach(
        _searchRepository.appliedFilterCount,
        onData: (appliedFilterCount) =>
            state.copyWith(appliedFilterCount: appliedFilterCount),
      );
    });

    on<SearchActionEvent>(
      (event, emit) {
        _searchRepository.search(query: event.query);
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<ToggleBrandActionEvent>(
      (event, emit) {
        _searchRepository.toggleBrand(brand: event.brand);
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<ToggleSizeActionEvent>(
      (event, emit) {
        _searchRepository.toggleSize(size: event.size);
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<ToggleColorActionEvent>(
      (event, emit) {
        _searchRepository.toggleColor(color: event.color);
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<ResetFilterActionEvent>(
      (event, emit) {
        _searchRepository.clearFilters();
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );
  }

}
