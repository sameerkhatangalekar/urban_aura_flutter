part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

final class GetCartEvent extends CartEvent {
  const GetCartEvent();
}

final class IncrementItemCountAction extends CartEvent {
  final String cartItemId;
  final int quantity;

  const IncrementItemCountAction({
    required this.cartItemId,
    required this.quantity,
  });
}

final class DecrementItemCountAction extends CartEvent {
  final String cartItemId;
  final int quantity;

  const DecrementItemCountAction({
    required this.cartItemId,
    required this.quantity,
  });
}
