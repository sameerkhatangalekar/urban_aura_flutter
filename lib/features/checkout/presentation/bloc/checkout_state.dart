part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();

  @override
  List<Object?> get props => const [];
}

final class CheckoutLoadingState extends CheckoutState {
  const CheckoutLoadingState();

  @override
  List<Object?> get props => [];
}

final class CheckoutRequestSuccessState extends CheckoutState {
  final String clientSecret;

  const CheckoutRequestSuccessState({required this.clientSecret});

  @override
  List<Object?> get props => [clientSecret];
}

final class CheckoutRequestFailedState extends CheckoutState {
  final String message;

  const CheckoutRequestFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class InitiatePaymentSheetFailedState extends CheckoutState {
  final String message;

  const InitiatePaymentSheetFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ShowPaymentSheetFailedState extends CheckoutState {
  final String message;

  const ShowPaymentSheetFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class PaymentConfirmedState extends CheckoutState {
  final String message;

  const PaymentConfirmedState({required this.message});

  @override
  List<Object?> get props => [message];
}
