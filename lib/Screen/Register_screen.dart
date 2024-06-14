import 'package:flutter/material.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/globals.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Image.asset(
                  'assets/images/Logo_2.png'), // Replace with your actual logo asset path
              SizedBox(height: 40),
              TextFormField(
                controller: usernameC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'username tidak boleh kosong';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email tidak boleh kosong';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pasword tidak boleh kosong';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 're enter pasword tidak boleh kosong';
                  }
                  if (value != passwordC.text) {
                    return 'password tidak sama';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Re-Enter Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    var response = await ApiClient.register(
                        usernameC.text, emailC.text, passwordC.text, context);
                    if (response != null) {
                      showSnackBarSuccess(
                          context, 'success registrasi silahkan login');
                      Navigator.of(context).pushNamed("/CreateAccount");
                    } else {
                      showSnackBarError(context, 'failed to register');
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
