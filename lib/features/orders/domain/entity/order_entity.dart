class OrderEntity {
  final List<OrderItemEntity> orderItems;
  final ShippingEntity shipping;
  final String id;
  final Status status;
  final double totalAmount;
  final String paymentId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderEntity({
    required this.orderItems,
    required this.shipping,
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.paymentId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class OrderItemEntity {
  final String productId;
  final String name;
  final String brand;
  final int quantity;
  final String description;
  final double price;
  final String color;
  final String size;
  final List<String> images;

  OrderItemEntity({
    required this.productId,
    required this.name,
    required this.brand,
    required this.quantity,
    required this.description,
    required this.price,
    required this.color,
    required this.size,
    required this.images,
  });
}

class ShippingEntity {
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String lineOne;
  final String postalCode;

  ShippingEntity({
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.contact,
    required this.lineOne,
    required this.postalCode,
  });
}

enum Status { placed, shipped, delivered, cancelled }

const statusMap = <String, Status>{
  'PLACED': Status.placed,
  'SHIPPED': Status.shipped,
  'DELIVERED': Status.delivered,
  'CANCELLED': Status.cancelled,
};
