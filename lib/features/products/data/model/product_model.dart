import 'dart:convert';

import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

List<ProductModel> parseProductList(String str) => List<ProductModel>.from(
      json
          .decode(
            str,
          )
          .map(
            (x) => ProductModel.fromJson(x),
          ),
    );

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.description,
    required super.price,
    required super.colors,
    required super.sizes,
    required super.images,
    required super.discount,
    required super.rating,
    required super.createdAt,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'colors': colors,
      'sizes': sizes,
      'images': images,
      'discount': discount,
      'rating': rating,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      description: map['description'],
      price: map['price'].toDouble(),
      colors: List<String>.from(map['colors']),
      sizes: List<String>.from(map['sizes']),
      images: List<String>.from(map['images']),
      discount: map['discount'],
      rating: map['rating'].toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? brand,
    String? description,
    double? price,
    List<String>? colors,
    List<String>? sizes,
    List<String>? images,
    int? discount,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      price: price ?? this.price,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      images: images ?? this.images,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
