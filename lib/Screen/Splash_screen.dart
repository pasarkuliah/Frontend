import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/HomeP.dart';
import 'package:nama_proyek/Screen/login_screen.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  void checkUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false);
      });
    } else {
      var user = await ApiClient.getUser(token);
      if (user == null) {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        });
      } else {
        sharedPreferences.setString('username', user.username!);
        sharedPreferences.setString('email', user.email!);
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/Logo_2.png'),
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
