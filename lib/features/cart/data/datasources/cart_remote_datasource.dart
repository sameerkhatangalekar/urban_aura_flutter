import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/features/cart/data/model/cart_model.dart';

abstract interface class CartRemoteDatasource {
  Future<CartModel> getCart();

  Future<SuccessModel> incrementItemCount({
    required String id,
    required int quantity,
  });

  Future<SuccessModel> decrementItemCount({
    required String id,
    required int quantity,
  });
}
