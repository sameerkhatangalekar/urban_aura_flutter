import 'package:flutter/foundation.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/cart_entity.dart';

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

final class AddToCartActionSuccessState extends CartState {
  final String message;

  const AddToCartActionSuccessState({
    required this.message,
  });
}

final class AddToCartActionFailedState extends CartState {
  final String message;

  const AddToCartActionFailedState({
    required this.message,
  });
}

final class RemoveFromCartActionSuccessState extends CartState {
  final String message;

  const RemoveFromCartActionSuccessState({
    required this.message,
  });
}

final class RemoveFromCartActionFailedState extends CartState {
  final String message;

  const RemoveFromCartActionFailedState({
    required this.message,
  });
}
