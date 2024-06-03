import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Shopping Cart', style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ShoppingCartItem(
            imageUrl: 'assets/images/sapu.jpg',
            itemName: 'Sapu Pembersih Lantai Fiber',
            itemPrice: 30000,
          ),
          ShoppingCartItem(
            imageUrl: 'assets/images/baju merah.jpg',
            itemName: 'Seragam Telkom University (Merah)',
            itemPrice: 125000,
          ),
          ShoppingCartItem(
            imageUrl: 'assets/images/mouse.jpg',
            itemName: 'Mouse Wireless',
            itemPrice: 80000,
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
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
        currentIndex: 1, // Set the current index to highlight the "Cart" tab
        onTap: (index) {
          if (index == 0) {
            // Navigate to HomeScreen
            Navigator.pushReplacementNamed(context, '/homeP');
          } else if (index == 2) {
            // Navigate to WishlistScreen
            Navigator.pushReplacementNamed(context, '/wishlist');
          }
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/BillingInfo');
          },
          child: Text('Checkout', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;

  ShoppingCartItem({
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 80,
              height: 80,
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
                  Text(
                    'Total Price: Rp.${itemPrice.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          // Handle quantity decrement
                        },
                      ),
                      Text(
                          '1'), // This should be dynamic based on item quantity
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          // Handle quantity increment
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
                // Handle item removal
              },
            ),
          ],
        ),
      ),
    );
  }
}
