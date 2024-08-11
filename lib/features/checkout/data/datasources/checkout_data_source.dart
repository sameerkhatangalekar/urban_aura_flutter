// ignore_for_file: non_constant_identifier_names

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:urban_aura_flutter/features/checkout/data/model/client_payment_secret_model.dart';

abstract interface class CheckoutDataSource {
  Future<ClientPaymentSecretModel> requestCheckout({
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<PaymentSheetPaymentOption?> initPaymentSheet({required String clientSecret});

  Future<PaymentSheetPaymentOption?> showPaymentSheet();


}
