part of 'products_bloc.dart';

@immutable
sealed class ProductsState {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class ProductListLoadingState extends ProductsState {
  const ProductListLoadingState();
}

final class ProductListLoadedState extends ProductsState {
  final List<ProductEntity> products;

  const ProductListLoadedState({
    required this.products,
  });
}

final class ProductListFailedState extends ProductsState {
  final String message;

  const ProductListFailedState({required this.message});
}
