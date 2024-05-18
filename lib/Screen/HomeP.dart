import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/ShoppingCart': (context) => ShoppingCartScreen(),
        '/Wishlist': (context) => WishlistScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // No navigation needed as we are already on the home page.
        break;
      case 1:
        Navigator.of(context).pushNamed('/ShoppingCart');
        break;
      case 2:
        Navigator.of(context).pushNamed('/Wishlist');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Container(
                  width: 332,
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
                CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Discount 50% OFF\nAll Members',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: 'Stationary'),
                    CategoryChip(label: 'Furniture'),
                    CategoryChip(label: 'Tools'),
                    CategoryChip(label: 'Attribute'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Product',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 100,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              children: [
                ProductItem(
                  imageUrl: 'assets/images/baju merah.jpg',
                  itemName: 'Seragam Telkom University (Merah)',
                  itemPrice: 125000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/baju putih.jpg',
                  itemName: 'Seragam Telkom University (Putih)',
                  itemPrice: 125000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/sapu.jpg',
                  itemName: 'Sapu Pembersih Lantai Fiber',
                  itemPrice: 18000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/mouse.jpg',
                  itemName: 'Mouse Wireless',
                  itemPrice: 80000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/sepatu hitam.jpg',
                  itemName: 'Sepatu Hitam',
                  itemPrice: 170000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/buku.jpg',
                  itemName: 'Buku Tulis',
                  itemPrice: 15000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/rak.jpg',
                  itemName: 'Rak Sepatu',
                  itemPrice: 70000,
                ),
                ProductItem(
                  imageUrl: 'assets/images/lanyard.jpg',
                  itemName: 'Lanyard',
                  itemPrice: 50000,
                ),
              ],
            ),
          ],
        ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Center(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
