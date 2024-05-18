import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Handle back action
            },
          ),
          title: Text('Back To Home', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ConfirmationScreen(),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Logo_2.png', // Replace with actual asset path
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Pesanan Diterima !!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Text(
            'Terima kasih atas pesanan Anda. Pesanan Anda sedang kami proses dan akan segera kami konfirmasi melalui aplikasi WhatsApp',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Add WhatsApp deep link or functionality
            },
            child: Text(
              'Jika Anda ingin menanyakan informasi terkait pesanan Anda, dpat menghubungi nomor berikut WhatsApp : 082257568458',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
