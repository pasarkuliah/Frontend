// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  Data? data;

  CartResponse({
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  List<Cart>? cart;
  int? totalPrice;

  Data({
    this.cart,
    this.totalPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: json["cart"] == null
            ? []
            : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "cart": cart == null
            ? []
            : List<dynamic>.from(cart!.map((x) => x.toJson())),
        "total_price": totalPrice,
      };
}

class Cart {
  int? id;
  int? userId;
  int? productId;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Cart({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: int.parse(json["id"].toString()),
        userId: int.parse(json["user_id"].toString()),
        productId: int.parse(json["product_id"].toString()),
        quantity: int.parse(json["quantity"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: int.parse(json["id"].toString()),
        name: json["name"],
        description: json["description"],
        price: double.parse(json["price"].toString()),
        imageUrl: json["image_url"],
        categoryId: int.parse(json["category_id"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image_url": imageUrl,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
