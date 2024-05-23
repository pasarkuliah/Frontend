import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/Register_screen.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80),
              Image.asset('assets/images/Logo_2.png'), // Make sure to add your logo in assets
              SizedBox(height: 80),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  Text('Remember me'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot password?'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/homeP");
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                  );
                },
                child: Text('Create account Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
