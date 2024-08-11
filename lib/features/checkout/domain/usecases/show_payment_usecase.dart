import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/repository/checkout_repository.dart';

final class ShowPaymentSheetUsecase
    implements UseCase<PaymentSheetPaymentOption?, NoParams> {
  final CheckoutRepository _checkoutRepository;

  const ShowPaymentSheetUsecase(
      {required CheckoutRepository checkoutRepository})
      : _checkoutRepository = checkoutRepository;

  @override
  Future<Either<Failure, PaymentSheetPaymentOption?>> call(
      NoParams param) async {
    return await _checkoutRepository.showPaymentSheet();
  }
}
