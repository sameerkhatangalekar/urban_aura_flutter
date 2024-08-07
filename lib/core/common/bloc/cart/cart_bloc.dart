import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/add_to_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/get_cart_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/increment_cart_item_count_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/remove_from_cart_usecase.dart';
import 'package:urban_aura_flutter/core/extensions.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/decrement_cart_item_count_usecase.dart';

import 'cart_state.dart';

part 'cart_event.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase _getCartUsecase;
  final IncrementCartItemCountUsecase _incrementCartItemCountUsecase;
  final DecrementCartItemCountUsecase _decrementCartItemCountUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;

  CartBloc(
      {required GetCartUsecase getCartUsecase,
      required DecrementCartItemCountUsecase decrementCartItemCountUsecase,
      required IncrementCartItemCountUsecase incrementCartItemCountUsecase,
      required RemoveFromCartUsecase removeFromCartUsecase,
      required AddToCartUsecase addToCartUsecase})
      : _getCartUsecase = getCartUsecase,
        _decrementCartItemCountUsecase = decrementCartItemCountUsecase,
        _incrementCartItemCountUsecase = incrementCartItemCountUsecase,
        _removeFromCartUsecase = removeFromCartUsecase,
        _addToCartUsecase = addToCartUsecase,
        super(const CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      final result = await _getCartUsecase(const NoParams());

      result.fold(
        (l) => emit(
          CartFailedState(
            message: l.message,
          ),
        ),
        (r) => emit(
          CartSuccessState(
            cartEntity: r,
          ),
        ),
      );
    });

    on<IncrementItemCountAction>(
      (event, emit) async {
        emit(const CartActionLoadingState());
        final result = await _incrementCartItemCountUsecase(
          IncrementCartItemCountParams(
            cartItemId: event.cartItemId,
            quantity: event.quantity,
          ),
        );

        result.fold(
          (l) => emit(IncrementItemCountActionFailedState(message: l.message)),
          (r) {
            emit(IncrementItemCountActionSuccessState(message: r.message));
            add(const GetCartEvent());
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );
    on<RemoveFromCartActionEvent>(
      (event, emit) async {
        emit(const CartActionLoadingState());
        final result = await _removeFromCartUsecase(event.cartItemId);

        result.fold(
          (l) => emit(RemoveFromCartActionFailedState(message: l.message)),
          (r) {
            emit(RemoveFromCartActionSuccessState(message: r.message));
            add(const GetCartEvent());
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<DecrementItemCountAction>(
      (event, emit) async {
        emit(const CartActionLoadingState());

        final result = await _decrementCartItemCountUsecase(
          DecrementCartItemCountParams(
            cartItemId: event.cartItemId,
            quantity: event.quantity,
          ),
        );

        result.fold(
          (l) => emit(
            DecrementItemCountActionFailedState(message: l.message),
          ),
          (r) {
            emit(DecrementItemCountActionSuccessState(message: r.message));
            add(const GetCartEvent());
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );

    on<AddToCartAction>(
      (event, emit) async {
        emit(const CartActionLoadingState());
        final result = await _addToCartUsecase(AddToCartParams(
            productId: event.productId, color: event.color, size: event.size));

        result.fold(
          (l) => emit(
            AddToCartActionFailedState(message: l.message),
          ),
          (r) => emit(
            AddToCartActionSuccessState(message: r.message),
          ),
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void onChange(Change<CartState> change) {
    change.log();
    super.onChange(change);
  }
}
