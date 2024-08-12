// ignore_for_file: non_constant_identifier_names
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/checkout/data/datasources/checkout_data_source.dart';
import 'package:urban_aura_flutter/features/checkout/domain/entity/client_payment_secret_entity.dart';
import 'package:urban_aura_flutter/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource _checkoutDataSource;

  const CheckoutRepositoryImpl({required CheckoutDataSource checkoutDatasource})
      : _checkoutDataSource = checkoutDatasource;

  @override
  Future<Either<Failure, ClientPaymentSecretEntity>> requestCheckout(
      {required String name,
      required String city,
      required String state,
      required String country,
      required String contact,
      required String line_one,
      required String postal_code}) async {
    try {
      final result = await _checkoutDataSource.requestCheckout(
          name: name,
          city: city,
          state: state,
          country: country,
          contact: contact,
          line_one: line_one,
          postal_code: postal_code);

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentSheetPaymentOption?>> initPaymentSheet(
      {required String clientSecret,required String publishableKey}) async {
    try {
      final result = await _checkoutDataSource.initPaymentSheet(
          clientSecret: clientSecret,publishableKey: publishableKey);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentSheetPaymentOption?>> showPaymentSheet() async {
    try {
      final result = await _checkoutDataSource.showPaymentSheet();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
