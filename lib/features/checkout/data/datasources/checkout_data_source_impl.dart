// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';
import 'package:urban_aura_flutter/features/checkout/data/datasources/checkout_data_source.dart';
import 'package:urban_aura_flutter/features/checkout/data/model/client_payment_secret_model.dart';

final class CheckoutDataSourceImpl implements CheckoutDataSource {
  final Dio _dio;
  final Stripe _stripe;

  const CheckoutDataSourceImpl({required Dio dio, required Stripe stripe})
      : _dio = dio,
        _stripe = stripe;

  @override
  Future<ClientPaymentSecretModel> requestCheckout(
      {required String name,
      required String city,
      required String state,
      required String country,
      required String contact,
      required String line_one,
      required String postal_code}) async {
    try {
      final result = await _dio.post(checkoutUrl, data: {
        'name': name,
        'city': city,
        'state': state,
        'country': country,
        'contact': contact,
        'line_one': line_one,
        'postal_code': postal_code
      });

      return ClientPaymentSecretModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<PaymentSheetPaymentOption?> initPaymentSheet(
      {required String clientSecret}) async {
    try {
      final result = await _stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'UrbanAura',
          googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'IN', currencyCode: 'USD', testEnv: true),
        ),
      );
      return result;
    } on StripeException catch (e) {
      throw ServerException(e.error.localizedMessage ??
          'Unknown error occurred while initiating payment');
    }
  }

  @override
  Future<PaymentSheetPaymentOption?> showPaymentSheet() async {
    try {
      final result = await _stripe.presentPaymentSheet();
      return result;
    } on StripeException catch (e) {
      throw ServerException(e.error.localizedMessage ??
          'Unknown error occurred while initiating payment');
    }
  }
}
