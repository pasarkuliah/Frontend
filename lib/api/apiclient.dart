import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nama_proyek/globals.dart';
import 'package:nama_proyek/resposne/cart_response.dart';
import 'package:nama_proyek/resposne/category.dart';
import 'package:nama_proyek/resposne/product.dart';
import 'package:nama_proyek/resposne/product_category_response.dart';
import 'package:nama_proyek/resposne/user.dart';
import 'package:http/http.dart' as http;
import 'package:nama_proyek/resposne/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static final String baseUrl = 'http://paskuh.cloud';
  static final String baseUrlApi = 'http://paskuh.cloud/api';

  static Future<UserResponse?> getUser(String token) async {
    var response = await http.get(Uri.parse('${baseUrlApi}/user'),
        headers: {"Authorization": "Bearer ${token}"});
    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    var response = await http.post(
      Uri.parse('$baseUrlApi/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to login: ${response.body}');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> register(String username, String email,
      String password, BuildContext context) async {
    var response = await http.post(
      Uri.parse('$baseUrlApi/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      showSnackBarError(context, jsonDecode(response.body)['message']);
    }
    return null;
  }

  static Future<ProductResponse?> getProducts(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
    var resposne = await http.get(Uri.parse("${baseUrlApi}/products"),
        headers: {"Authorization": "Bearer ${token}"});
    if (resposne.statusCode != 200) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } else {
      return ProductResponse.fromJson(jsonDecode(resposne.body));
    }
    return null;
  }

  static Future<CategoryResponse?> getCategories(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
    var resposne = await http.get(Uri.parse("${baseUrlApi}/categories"),
        headers: {"Authorization": "Bearer ${token}"});
    if (resposne.statusCode != 200) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } else {
      return CategoryResponse.fromJson(jsonDecode(resposne.body));
    }
    return null;
  }

  static Future<ProductCategoryResponse?> getProductByCategory(
      BuildContext context, id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
    var resposne = await http.get(Uri.parse("${baseUrlApi}/products/${id}"),
        headers: {"Authorization": "Bearer ${token}"});
    if (resposne.statusCode != 200) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } else {
      return ProductCategoryResponse.fromJson(jsonDecode(resposne.body));
    }
    return null;
  }

  static Future<CartResponse?> getCart(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
    var resposne = await http.get(Uri.parse("${baseUrlApi}/cart"),
        headers: {"Authorization": "Bearer ${token}"});
    if (resposne.statusCode != 200) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } else {
      return CartResponse.fromJson(jsonDecode(resposne.body));
    }
    return null;
  }

  static Future<bool> addToCart(BuildContext context, productId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      showSnackBarError(context, 'ops login dulu');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return false;
    }
    var resposne = await http.post(Uri.parse("${baseUrlApi}/cart"),
        headers: {
          "Authorization": "Bearer ${token}",
          "content-type": 'application/json'
        },
        body: jsonEncode({"product_id": productId}));
    if (resposne.statusCode != 201) {
      showSnackBarError(context, jsonDecode(resposne.body)['message']);
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> updateCartItemQuantity(
      BuildContext context, int cartItemId, String action) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    final response = await http.patch(
      Uri.parse('$baseUrlApi/cart/$cartItemId'),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${token}"
      },
      body: jsonEncode(<String, String>{'action': action}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Handle error
      print('Failed to update cart item quantity: ${response.statusCode}');
      return false;
    }
  }

  static Future<bool> deleteFromChart(
      BuildContext context, int cartItemId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrlApi/cart/$cartItemId'),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${token}"
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addToWishlist(int productId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$baseUrlApi/wishlist'),
      body: jsonEncode({'product_id': productId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      print('Product added to wishlist successfully');
      return true;
    } else {
      return false;
      // throw Exception('Failed to add product to wishlist');
    }
  }

  static Future<bool> removeFromWishlist(int productId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse('$baseUrlApi/wishlist'),
      body: jsonEncode({'product_id': productId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<WishListResponse?> getWishlist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${baseUrlApi}/wishlist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${sharedPreferences.getString('token')}"
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      return WishListResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<bool> checkoutProcess({
    required String name,
    required String address,
    required String city,
    required String phone,
    required String paymentMethod,
    required List<Cart> cartItems,
  }) async {
    try {
      final url = Uri.parse('$baseUrlApi/checkout');
      final cartItemsJson = cartItems.map((item) => item.toJson()).toList();
      print(cartItemsJson);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${sharedPreferences.getString('token')}"
        },
        body: json.encode({
          'name': name,
          'address': address,
          'city': city,
          'phone': phone,
          'payment_method': paymentMethod,
          'cart_items': cartItemsJson,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        return true;
      } else {
        print('Error: ${response.reasonPhrase}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
