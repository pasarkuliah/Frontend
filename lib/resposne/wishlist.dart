// To parse this JSON data, do
//
//     final wishList = wishListFromJson(jsonString);

import 'dart:convert';

import 'package:nama_proyek/resposne/product.dart';

WishListResponse wishListFromJson(String str) =>
    WishListResponse.fromJson(json.decode(str));

String wishListToJson(WishListResponse data) => json.encode(data.toJson());

class WishListResponse {
  List<Wishlist>? wishlist;

  WishListResponse({
    this.wishlist,
  });

  factory WishListResponse.fromJson(Map<String, dynamic> json) =>
      WishListResponse(
        wishlist: json["wishlist"] == null
            ? []
            : List<Wishlist>.from(
                json["wishlist"]!.map((x) => Wishlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wishlist": wishlist == null
            ? []
            : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
      };
}

class Wishlist {
  int? id;
  int? productId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Wishlist({
    this.id,
    this.productId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: int.parse(json["id"].toString()),
        productId: int.parse(json["product_id"].toString()),
        userId: int.parse(json["user_id"].toString()),
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
        "product_id": productId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}
