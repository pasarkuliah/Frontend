import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/HomeP.dart';
import 'package:nama_proyek/Screen/Splash_screen.dart';
import 'package:nama_proyek/Screen/ShoppingCart.dart' as ShoppingCart;
import 'package:nama_proyek/Screen/Wishlist.dart' as Wishlist;
import 'package:nama_proyek/Screen/BillingInfo.dart';
import 'package:nama_proyek/Screen/Billing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasar Kuliah (PasKu)',
      theme: ThemeData(
        primaryColor: const Color(0xFF673AB7), 
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF673AB7), 
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "/homeP": (context) => HomeScreen(),
        "/ShoppingCart": (context) => ShoppingCart.ShoppingCartScreen(),
        "/wishlist": (context) => Wishlist.WishlistScreen(),
        "/BillingInfo": (context) =>BillingInformationScreen(),
        "/Billing" :(context) => ConfirmationScreen(),
      },
    );
  }
}