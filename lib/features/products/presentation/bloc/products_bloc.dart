import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_product_by_id_usecase.dart';
import 'package:urban_aura_flutter/features/products/domain/usecase/get_products_usecase.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUsecase _getProductsUseCase;

  //final GetProductsByIdUsecase _getProductsByIdUsecase;

  ProductsBloc(
      {required GetProductsUsecase getProductsUsecase,
      required GetProductsByIdUsecase getProductsByIdUsecase})
      : _getProductsUseCase = getProductsUsecase,
        // _getProductsByIdUsecase = getProductsByIdUsecase,
        super(const ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(const ProductListLoadingState());
      final result = await _getProductsUseCase(const NoParams());
      result.fold(
        (l) => emit(
          ProductListFailedState(
            message: l.message,
          ),
        ),
        (r) => emit(
          ProductListLoadedState(products: r),
        ),
      );
    });
  }
}
