

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
        title: Text('Categories'),
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
                CategoryChip(label: 'All'),
                CategoryChip(label: 'Electronics'),
                CategoryChip(label: 'Furniture'),
                CategoryChip(label: 'Tools'),
                CategoryChip(label: 'All Products'),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(8),
              children: [
                ProductItem(
                  imageUrl: 'assets/images/seragam_telkom_university_merah.png',
                  itemName: 'Seragam Telkom University (Merah)',
                  itemPrice: 125000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/seragam_telkom_university_putih.png',
                  itemName: 'Seragam Telkom University (Putih)',
                  itemPrice: 125000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/sapu_pembersih_lantai_fiber.png',
                  itemName: 'Sapu Pembersih Lantai Fiber',
                  itemPrice: 1000000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/mouse_wireless.png',
                  itemName: 'Mouse Wireless',
                  itemPrice: 80000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/sepatu_hitam.png',
                  itemName: 'Sepatu Hitam',
                  itemPrice: 150000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/buku_tulis.png',
                  itemName: 'Buku Tulis',
                  itemPrice: 10000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/rak_sepatu.png',
                  itemName: 'Rak Sepatu',
                  itemPrice: 70000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/landyard.png',
                  itemName: 'Landyard',
                  itemPrice: 5000,
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
        currentIndex: 0, // Set the current index to highlight the "Home" tab
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[200],
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
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    // Add to wishlist logic
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
