import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Wishlist')),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          WishlistItem(
            imageUrl: 'assets/images/baju putih.jpg',
            itemName: 'Seragam Telkom University (Putih)',
            itemPrice: 125000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/rak.jpg',
            itemName: 'Rak Sepatu',
            itemPrice: 70000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/sofa kuning.jpg',
            itemName: 'Sofa Kuning',
            itemPrice: 1250000,
          ),
          WishlistItem(
            imageUrl: 'assets/images/drone.jpg',
            itemName: 'Drone',
            itemPrice: 8000000,
          ),
          WishlistItem(
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
        currentIndex:
        2, // Set the current index to highlight the "Wishlist" tab
        onTap: (index) {
          if (index == 0) {
            // Navigate to HomeScreen
            Navigator.pushReplacementNamed(context, '/homeP');
          } else if (index == 1) {
            // Navigate to ShoppingCartScreen
            Navigator.pushReplacementNamed(context, '/ShoppingCart');
          }
        },
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
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double
                        .infinity, // Ensure the image covers the full width
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
            ),
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
                    foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 36),
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

void main() {
  runApp(MaterialApp(
    home: WishlistScreen(),
    routes: {
      '/homeP': (context) => HomeScreen(), // Define your HomeScreen widget here
      '/ShoppingCart': (context) =>
          ShoppingCartScreen(), // Define your ShoppingCartScreen widget here
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Center(
        child: Text('Shopping Cart Screen'),
      ),
    );
  }
}
