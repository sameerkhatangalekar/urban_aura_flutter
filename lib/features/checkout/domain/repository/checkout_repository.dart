// ignore_for_file: non_constant_identifier_names

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/checkout/domain/entity/client_payment_secret_entity.dart';

abstract interface class CheckoutRepository {
  Future<Either<Failure, ClientPaymentSecretEntity>> requestCheckout({
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<Either<Failure, PaymentSheetPaymentOption?>> initPaymentSheet(
      {required String clientSecret,required String publishableKey});

  Future<Either<Failure, PaymentSheetPaymentOption?>> showPaymentSheet();

}
