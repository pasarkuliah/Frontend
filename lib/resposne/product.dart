// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  List<Product>? data;

  ProductResponse({
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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
  bool? wishlist;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.wishlist});

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
      wishlist: json['wishlist']);

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
