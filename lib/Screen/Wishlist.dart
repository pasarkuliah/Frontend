import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8),
        children: [
          WishlistItem(
            imageUrl: 'assets/images/seragam_telkom_university_putih.png',
            itemName: 'Seragam Telkom University (Putih)',
            itemPrice: 125000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/rak_sepatu.png',
            itemName: 'Rak Sepatu',
            itemPrice: 70000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/sofa_kuning.png',
            itemName: 'Sofa Kuning',
            itemPrice: 1250000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/drone.png',
            itemName: 'Drone',
            itemPrice: 8000000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/mouse_wireless.png',
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
        currentIndex: 2, // Set the current index to highlight the "Wishlist" tab
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;

  WishlistItem({
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    // Remove from wishlist logic
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
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
                  'Rp.${itemPrice.toString()}',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add to cart logic
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Add To Cart'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
