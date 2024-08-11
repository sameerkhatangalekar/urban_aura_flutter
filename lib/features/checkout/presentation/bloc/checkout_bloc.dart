import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:urban_aura_flutter/core/usecase.dart';

import 'package:urban_aura_flutter/features/checkout/domain/usecases/initiate_payment_usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/usecases/request_checkout_usecase.dart';
import 'package:urban_aura_flutter/features/checkout/domain/usecases/show_payment_usecase.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final RequestCheckoutUsecase _requestCheckoutUsecase;

  final InitiatePaymentUsecase _initiatePaymentUsecase;
  final ShowPaymentSheetUsecase _showPaymentSheetUsecase;

  CheckoutBloc(
      {required RequestCheckoutUsecase requestCheckoutUsecase,
      required InitiatePaymentUsecase initiatePaymentUsecase,
      required ShowPaymentSheetUsecase showPaymentSheetUsecase})
      : _requestCheckoutUsecase = requestCheckoutUsecase,
        _initiatePaymentUsecase = initiatePaymentUsecase,
        _showPaymentSheetUsecase = showPaymentSheetUsecase,
        super(const CheckoutInitial()) {
    on<CheckoutRequestedActionEvent>((event, emit) async {
      emit(const CheckoutLoadingState());

      final result = await _requestCheckoutUsecase(
        RequestCheckoutParams(
            name: event.name,
            city: event.city,
            state: event.state,
            country: event.country,
            contact: event.contact,
            line_one: event.line_one,
            postal_code: event.postal_code),
      );
      result.fold(
        (l) => emit(
          CheckoutRequestFailedState(message: l.message),
        ),
        (r) {
          emit(CheckoutRequestSuccessState(clientSecret: r.clientSecret));
          add(InitiatePaymentSheetEvent(clientSecret: r.clientSecret));
        },
      );
    });
    on<InitiatePaymentSheetEvent>((event, emit) async {
      final result = await _initiatePaymentUsecase(event.clientSecret);
      result.fold(
        (l) => emit(
          InitiatePaymentSheetFailedState(message: l.message),
        ),
        (r) {
          add(ShowPaymentSheetEvent(clientSecret: event.clientSecret));
        },
      );
    });
    on<ShowPaymentSheetEvent>((event, emit) async {
      final result = await _showPaymentSheetUsecase(const NoParams());
      result.fold(
        (l) => emit(
          ShowPaymentSheetFailedState(message: l.message),
        ),
        (r) {
          emit(const PaymentConfirmedState(message: 'Payment successful'));
        },
      );
    });
  }
}
