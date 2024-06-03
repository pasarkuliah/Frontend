import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop("/HomeP");
          },
        ),
        title: Text('Furniture'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryChip(label: 'Stationary'),
                CategoryChip(label: 'Furniture'),
                CategoryChip(label: 'Tools', isSelected: true),
                CategoryChip(label: 'Attribute'),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(8),
              children: [
                ProductItem(
                  imageUrl: 'assets/images/sapu.jpg',
                  itemName: 'Sapu Pembersih Lantai Fiber',
                  itemPrice: 18000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/drone.jpg',
                  itemName: 'Drone',
                  itemPrice: 8000000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/mouse.jpg',
                  itemName: 'Mouse Wireless',
                  itemPrice: 80000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/sofa.jpg',
                  itemName: 'Sofa Putih',
                  itemPrice: 1300000,
                ),
              ],
            ),
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
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/ShoppingCart');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/wishlist');
              break;
          }
        },
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.grey[400] : Colors.grey[200],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;

  ProductItem({
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(imageUrl, fit: BoxFit.cover, height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Rp. $itemPrice',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            label: Text('Add To Cart'),
          ),
        ],
      ),
    );
  }
}
