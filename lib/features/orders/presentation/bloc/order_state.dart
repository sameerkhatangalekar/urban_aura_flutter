part of 'order_bloc.dart';

@immutable
sealed class OrderState extends Equatable {
  const OrderState();
}

final class OrderInitial extends OrderState {
  const OrderInitial();

  @override
  List<Object?> get props => [];
}

final class OrdersLoadingState extends OrderState {
  const OrdersLoadingState();

  @override
  List<Object?> get props => [];
}

final class OrdersLoadedState extends OrderState {
  final List<OrderEntity> orders;

  const OrdersLoadedState({required this.orders});

  @override
  List<Object?> get props => [orders];
}

final class OrdersFailedState extends OrderState {
  final String message;

  const OrdersFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class OrderLoadingState extends OrderState {
  const OrderLoadingState();
  @override
  List<Object?> get props => [];
}

final class OrderLoadedState extends OrderState {
  final OrderEntity order;

  const OrderLoadedState({required this.order});

  @override
  List<Object?> get props => [order];
}

final class OrderFailedState extends OrderState {
  final String message;

  const OrderFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class OrderActionProcessingState extends OrderState {
  const OrderActionProcessingState();

  @override
  List<Object?> get props => [];
}

final class OrderActionSuccessState extends OrderState {
  final String message;

  const OrderActionSuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class OrderActionFailedState extends OrderState {
  final String message;

  const OrderActionFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}
