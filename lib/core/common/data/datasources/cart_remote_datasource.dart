import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/core/common/data/models/cart_model.dart';

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

  Future<SuccessModel> addToCart({
    required String productId,
    required int quantity,
    required String size,
    required String color,
  });

  Future<SuccessModel> removeFromCart({required String cartItemId});
}
