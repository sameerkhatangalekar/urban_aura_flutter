part of 'products_bloc.dart';

@immutable
sealed class ProductsState extends Equatable {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();

  @override
  List<Object?> get props => [];
}

final class ProductListLoadingState extends ProductsState {
  const ProductListLoadingState();

  @override
  List<Object?> get props => [];
}

final class ProductListLoadedState extends ProductsState {
  final List<ProductEntity> products;

  const ProductListLoadedState({
    required this.products,
  });

  @override
  List<Object?> get props => [products];
}

final class ProductListFailedState extends ProductsState {
  final String message;

  const ProductListFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}
