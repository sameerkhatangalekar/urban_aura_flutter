// ignore_for_file: non_constant_identifier_names

import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/entity/client_payment_secret_entity.dart';
import 'package:urban_aura_flutter/features/checkout/domain/repository/checkout_repository.dart';

class RequestCheckoutParams {
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const RequestCheckoutParams(
      {required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class RequestCheckoutUsecase
    implements UseCase<ClientPaymentSecretEntity, RequestCheckoutParams> {
  final CheckoutRepository _checkoutRepository;

  const RequestCheckoutUsecase({required CheckoutRepository checkoutRepository})
      : _checkoutRepository = checkoutRepository;

  @override
  Future<Either<Failure, ClientPaymentSecretEntity>> call(
      RequestCheckoutParams param) async {
    return await _checkoutRepository.requestCheckout(
        name: param.name,
        city: param.city,
        state: param.state,
        country: param.country,
        contact: param.contact,
        line_one: param.line_one,
        postal_code: param.postal_code);
  }
}
