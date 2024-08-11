// ignore_for_file: non_constant_identifier_names

part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {
  const CheckoutEvent();
}

final class CheckoutRequestedActionEvent extends CheckoutEvent {
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const CheckoutRequestedActionEvent(
      {required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class InitiatePaymentSheetEvent extends CheckoutEvent {
  final String clientSecret;

  const InitiatePaymentSheetEvent({required this.clientSecret});
}

final class ShowPaymentSheetEvent extends CheckoutEvent {
  final String clientSecret;

  const ShowPaymentSheetEvent({required this.clientSecret});
}
