import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';

import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/repository/checkout_repository.dart';

final class InitiatePaymentUsecase
    implements UseCase<PaymentSheetPaymentOption?, String> {
  final CheckoutRepository _checkoutRepository;

  const InitiatePaymentUsecase({required CheckoutRepository checkoutRepository})
      : _checkoutRepository = checkoutRepository;

  @override
  Future<Either<Failure, PaymentSheetPaymentOption?>> call(String param) async {
    return await _checkoutRepository.initPaymentSheet(clientSecret: param);
  }
}
