import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';

final class OrderModel extends OrderEntity {
  OrderModel(
      {required super.orderItems,
      required super.shipping,
        required super.orderId,
      super.refund,
      required super.id,
      required super.status,
      required super.totalAmount,
      required super.paymentId,
      required super.userId,
      required super.createdAt,
      required super.updatedAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json['orderId'],
        orderItems: List<OrderItemModel>.from(
            json["orderItems"].map((x) => OrderItemModel.fromJson(x))),
        shipping: ShippingModel.fromJson(json["shipping"]),
        refund: json['refund'] == null ?  null : RefundModel.fromJson(json['refund']) ,
        id: json["id"],
        status: statusMap[json["status"]]!,
        totalAmount: json["totalAmount"]?.toDouble(),
        paymentId: json["paymentId"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderItems": orderItems,
        "shipping": shipping,
        "refund" : refund,
        "id": id,
        "status": status,
        "totalAmount": totalAmount,
        "paymentId": paymentId,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class OrderItemModel extends OrderItemEntity {
  OrderItemModel(
      {required super.productId,
      required super.name,
      required super.brand,
      required super.quantity,
      required super.description,
      required super.price,
      required super.color,
      required super.size,
      required super.images});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        productId: json["productId"],
        name: json["name"],
        brand: json["brand"],
        quantity: json["quantity"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        color: json["color"],
        size: json["size"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "brand": brand,
        "quantity": quantity,
        "description": description,
        "price": price,
        "color": color,
        "size": size,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

final class ShippingModel extends ShippingEntity {
  ShippingModel(
      {required super.name,
      required super.city,
      required super.state,
      required super.country,
      required super.contact,
      required super.lineOne,
      required super.postalCode});

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        name: json["name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        contact: json["contact"],
        lineOne: json["line_one"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "state": state,
        "country": country,
        "contact": contact,
        "line_one": lineOne,
        "postal_code": postalCode,
      };
}

final class RefundModel extends RefundEntity {
  RefundModel(
      {required super.status,
         super.receipt,
      });

  factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
    status: json["status"],
    receipt: json["receipt"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "receipt": receipt,

  };
}