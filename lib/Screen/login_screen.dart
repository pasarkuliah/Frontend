import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/Register_screen.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 80),
                Image.asset(
                    'assets/images/Logo_2.png'), // Pastikan untuk menambahkan logo Anda di assets
                SizedBox(height: 80),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'username tidak boleh kosong';
                    }
                  },
                  controller: usernameC,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password tidak boleh kosong';
                    }
                  },
                  controller: passwordC,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    if (_key.currentState!.validate()) {
                      var res =
                          await ApiClient.login(usernameC.text, passwordC.text);
                      if (res == null) {
                        showSnackBarError(
                            context, 'The provided credentials are incorrect');
                      } else {
                        sharedPreferences.setBool('login', true);
                        sharedPreferences.setString(
                            'token', res['access_token']);

                        var user = await ApiClient.getUser(res['access_token']);
                        sharedPreferences.setString(
                            'username', user!.username!);
                        showSnackBarSuccess(context, 'Success to login');
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/homeP', (route) => false);
                      }
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50)),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Create account Signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
