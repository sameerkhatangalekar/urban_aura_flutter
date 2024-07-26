part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {
  const ProductsEvent();
}

final class LoadProductsEvent extends ProductsEvent {}

