part of 'cart_bloc.dart';

@immutable
sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoadingState extends CartState {
  const CartLoadingState();
}

final class CartSuccessState extends CartState {
  final CartEntity cartEntity;

  const CartSuccessState({required this.cartEntity});
}

final class CartFailedState extends CartState {
  final String message;

  const CartFailedState({
    required this.message,
  });
}

final class CartActionLoadingState extends CartState {
  const CartActionLoadingState();
}

final class IncrementItemCountActionSuccessState extends CartState {
  final String message;

  const IncrementItemCountActionSuccessState({
    required this.message,
  });
}

final class IncrementItemCountActionFailedState extends CartState {
  final String message;

  const IncrementItemCountActionFailedState({
    required this.message,
  });
}

final class DecrementItemCountActionSuccessState extends CartState {
  final String message;

  const DecrementItemCountActionSuccessState({
    required this.message,
  });
}

final class DecrementItemCountActionFailedState extends CartState {
  final String message;

  const DecrementItemCountActionFailedState({
    required this.message,
  });
}
