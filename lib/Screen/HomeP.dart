import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
              child: Row(
                children: [
                  Expanded(
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
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/Profile");
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.jpg'), // Path to profile image
                    ),
                  )

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/bg.jpg', // Path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/Cat_Stationery");
                      },
                      child: Image.asset(
                        'assets/images/Stationery.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/Cat_Furniture");
                      },
                      child: Image.asset(
                        'assets/images/Furniture.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/Cat_Tools");
                      },
                      child: Image.asset(
                        'assets/images/Tools.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/Cat_Attribute");
                      },
                      child: Image.asset(
                        'assets/images/Attribute.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
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
        currentIndex: 0, // Set the current index to highlight the "Home" tab
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Rp. $itemPrice',
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text('Add To Cart'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 36),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}