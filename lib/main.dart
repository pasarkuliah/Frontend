import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/HomeP.dart';
import 'package:nama_proyek/Screen/Splash_screen.dart';
import 'package:nama_proyek/Screen/ShoppingCart.dart' as ShoppingCart;
import 'package:nama_proyek/Screen/Wishlist.dart' as Wishlist;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pasku',
      theme: ThemeData(
        primaryColor:
            const Color(0xFF673AB7), // Ubah primary color sesuai keinginan Anda
        colorScheme: ColorScheme.light(
          primary: const Color(
              0xFF673AB7), // Anda juga bisa menggunakan primary di dalam colorScheme jika diperlukan
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "/homeP": (context) => HomeScreen(),
        "/ShoppingCart": (context) => ShoppingCart.ShoppingCartScreen(),
        "/Wishlist": (context) => Wishlist.WishlistScreen(),
      },
    );
  }
}
