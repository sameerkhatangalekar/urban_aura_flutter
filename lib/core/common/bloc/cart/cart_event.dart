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

final class RemoveFromCartActionEvent extends CartEvent {
  final String cartItemId;

  const RemoveFromCartActionEvent({
    required this.cartItemId,
  });
}

final class AddToCartAction extends CartEvent with EquatableMixin {
  final String productId;
  final int quantity;
  final String color;
  final String size;

  const AddToCartAction(
      {required this.productId,
      this.quantity = 1,
      required this.color,
      required this.size});

  @override
  List<Object?> get props => [productId, quantity, color, size];
}
