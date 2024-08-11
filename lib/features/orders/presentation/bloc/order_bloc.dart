import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/cancel_order_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/usecases/get_orders_by_user_usecase.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersByUserUsecase _getOrdersByUserUsecase;
  final CancelOrderByIdUsecase _cancelOrderByIdUsecase;
  final GetOrderByIdUsecase _getOrderByIdUsecase;

  OrderBloc({
    required GetOrdersByUserUsecase getOrdersByUserUsecase,
    required CancelOrderByIdUsecase cancelOrderByIdUsecase,
    required GetOrderByIdUsecase getOrderByIdUsecase,
  })  : _getOrdersByUserUsecase = getOrdersByUserUsecase,
        _cancelOrderByIdUsecase = cancelOrderByIdUsecase,
        _getOrderByIdUsecase = getOrderByIdUsecase,
        super(const OrderInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(const OrdersLoadingState());

      final result = await _getOrdersByUserUsecase(const NoParams());
      result.fold(
        (l) => emit(
          OrdersFailedState(
            message: l.message,
          ),
        ),
        (r) => emit(
          OrdersLoadedState(orders: r),
        ),
      );
    });

    on<GetOrderByIdActionEvent>((event, emit) async {
      emit( const OrderLoadingState());

      final result = await _getOrderByIdUsecase(event.orderId);
      result.fold(
        (l) => emit(
          OrderFailedState(
            message: l.message,
          ),
        ),
        (r) => emit(
          OrderLoadedState(order: r),
        ),
      );
    });

    on<CancelOrderActionEvent>((event, emit) async {
      emit(const OrderActionProcessingState());

      final result = await _cancelOrderByIdUsecase(event.orderId);
      result.fold(
        (l) => emit(
          OrderActionFailedState(
            message: l.message,
          ),
        ),
        (r) {
          emit(
            OrderActionSuccessState(message: r.message),
          );
          add(GetOrderByIdActionEvent(orderId: event.orderId));
        },
      );
    });
  }
}
