// To parse this JSON data, do
//
//     final productCategoryResponse = productCategoryResponseFromJson(jsonString);

import 'dart:convert';

ProductCategoryResponse productCategoryResponseFromJson(String str) =>
    ProductCategoryResponse.fromJson(json.decode(str));

String productCategoryResponseToJson(ProductCategoryResponse data) =>
    json.encode(data.toJson());

class ProductCategoryResponse {
  Data? data;

  ProductCategoryResponse({
    this.data,
  });

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductCategoryResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  List<Product>? products;
  Category? category;

  Data({
    this.products,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "category": category?.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: int.parse(json["id"].toString()),
        name: json["name"],
        imageUrl: json["image_url"],
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
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
