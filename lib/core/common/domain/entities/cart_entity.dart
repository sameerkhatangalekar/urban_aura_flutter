class CartEntity {
  final List<CartItem> cart;

  final double cartTotal;

   CartEntity({
    required this.cartTotal,
    required this.cart,
  });
}

class CartItem {
  final String id;
  final String color;
  final int quantity;
  final String size;
  final String userId;
  final String productId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  CartItem(
      {required this.id,
      required this.color,
      required this.quantity,
      required this.size,
      required this.userId,
      required this.productId,
      required this.createdAt,
      required this.updatedAt,
      required this.product});
}

class Product {
  final String id;
  final String name;
  final String description;
  final String brand;
  final List<String> images;
  final double price;
  final int discount;
  final double rating;

  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.brand,
      required this.images,
      required this.discount,
      required this.rating,
      required this.price});
}
