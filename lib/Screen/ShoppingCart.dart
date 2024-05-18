import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCartScreen(),
    );
  }
}

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ShoppingCartItem(
            imageUrl: 'assets/images/sapu_pembersih_lantai_fiber.png',
            itemName: 'Sapu Pembersih Lantai Fiber',
            itemPrice: 1000000,
            quantity: 5,
          ),
          ShoppingCartItem(
            imageUrl: 'assets/images/seragam_telkom_university_merah.png',
            itemName: 'Seragam Telkom University (Merah)',
            itemPrice: 125000,
            quantity: 1,
          ),
          ShoppingCartItem(
            imageUrl: 'assets/images/mouse_wireless.png',
            itemName: 'Mouse Wireless',
            itemPrice: 80000,
            quantity: 3,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/homeP');
          }else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/Wishlist');
          }
        }
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;
  final int quantity;

  ShoppingCartItem({
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Total Price: Rp.${itemPrice.toString()}'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Quantity: '),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // Decrease quantity logic
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Increase quantity logic
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete item logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
