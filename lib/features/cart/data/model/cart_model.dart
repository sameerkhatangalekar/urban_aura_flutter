import 'package:urban_aura_flutter/features/cart/domain/entity/cart_entity.dart';

final class CartModel extends CartEntity {
  CartModel({required super.cartTotal, required super.cart});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "cart": cart,
      "cartTotal": cartTotal,
    };
  }

  CartModel copyWith({
    List<CartItem>? cart,
    double? cartTotal,
  }) {
    return CartModel(
      cartTotal: cartTotal ?? this.cartTotal,
      cart: cart ?? this.cart,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> jsonMap) {
    return CartModel(
      cart: List<CartItemModel>.from(
        jsonMap['cart'].map((x) => CartItemModel.fromJson(x)),
      ),
      cartTotal: jsonMap['cartTotal'].toDouble(),
    );
  }
}

class CartItemModel extends CartItem {
  CartItemModel({
    required super.id,
    required super.color,
    required super.quantity,
    required super.size,
    required super.userId,
    required super.productId,
    required super.createdAt,
    required super.updatedAt,
    required super.product,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'quantity': quantity,
      'size': size,
      'userId': userId,
      'productId': productId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'product': product
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      color: map['color'],
      quantity: map['quantity'],
      size: map['size'],
      userId: map['userId'],
      productId: map['productId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      product: ProductModel.fromJson(map['product']),
    );
  }

  CartItemModel copyWith({
    String? id,
    String? color,
    int? quantity,
    String? size,
    String? userId,
    String? productId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) {
    return CartItemModel(
        id: id ?? this.id,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        size: size ?? this.size,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product);
  }
}

class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.brand,
      required super.images,
      required super.discount,
      required super.rating,
      required super.price});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'images': images,
      'discount': discount,
      'rating': rating,
      'price': price
    };
  }

  ProductModel copyWith(
      {String? id,
      String? name,
      String? description,
      String? brand,
      List<String>? images,
      int? discount,
      double? rating,
      double? price}) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      images: images ?? this.images,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      price: price ?? this.rating,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      brand: map['brand'],
      images: List<String>.from(map['images']),
      discount: map['discount'],
      rating: map['rating'].toDouble(),
      price: map['price'].toDouble(),
    );
  }
}
