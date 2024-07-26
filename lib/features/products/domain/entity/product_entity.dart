// ignore_for_file: constant_identifier_names


class ProductEntity {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final List<String> colors;
  final List<String> sizes;
  final List<String> images;
  final int discount;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.colors,
    required this.sizes,
    required this.images,
    required this.discount,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });
  //
  // ProductEntity copyWith({
  //   String? id,
  //   String? name,
  //   String? brand,
  //   String? description,
  //   double? price,
  //   List<String>? colors,
  //   List<Size>? sizes,
  //   List<String>? images,
  //   int? discount,
  //   int? rating,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) =>
  //     ProductEntity(
  //       id: id ?? this.id,
  //       name: name ?? this.name,
  //       brand: brand ?? this.brand,
  //       description: description ?? this.description,
  //       price: price ?? this.price,
  //       colors: colors ?? this.colors,
  //       sizes: sizes ?? this.sizes,
  //       images: images ?? this.images,
  //       discount: discount ?? this.discount,
  //       rating: rating ?? this.rating,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //     );
  //
  // factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
  //       id: json["id"],
  //       name: json["name"],
  //       brand: json["brand"],
  //       description: json["description"],
  //       price: json["price"]?.toDouble(),
  //       colors: List<String>.from(json["colors"].map((x) => x)),
  //       sizes: List<Size>.from(json["sizes"].map((x) => x)),
  //       images: List<String>.from(json["images"].map((x) => x)),
  //       discount: json["discount"],
  //       rating: json["rating"],
  //       createdAt: DateTime.parse(json["createdAt"]),
  //       updatedAt: DateTime.parse(json["updatedAt"]),
  //     );
  //
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "brand": brand,
  //       "description": description,
  //       "price": price,
  //       "colors": List<dynamic>.from(colors.map((x) => x)),
  //       "sizes": List<dynamic>.from(sizes.map((x) => x)),
  //       "images": List<dynamic>.from(images.map((x) => x)),
  //       "discount": discount,
  //       "rating": rating,
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //     };
}

enum Size { XS, S, M, L, XL }
