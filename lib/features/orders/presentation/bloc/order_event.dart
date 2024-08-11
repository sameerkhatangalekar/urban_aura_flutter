part of 'order_bloc.dart';

@immutable
sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

final class GetOrdersEvent extends OrderEvent {
  const GetOrdersEvent();

  @override
  List<Object?> get props => [];
}

final class CancelOrderActionEvent extends OrderEvent {
  final String orderId;

  const CancelOrderActionEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

final class GetOrderByIdActionEvent extends OrderEvent {
  final String orderId;

  const GetOrderByIdActionEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
