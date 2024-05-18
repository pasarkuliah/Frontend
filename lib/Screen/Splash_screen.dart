import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/Logo_2.png'),
      ),
    );
  }
}