import 'package:flutter/material.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/globals.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isUpdate = false;

  Future<void> updateScreen() async {
    setState(() {
      isUpdate != isUpdate;
    });
  }

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
      body: FutureBuilder(
        future: ApiClient.getWishlist(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount:
                      snapshot.hasData ? snapshot.data!.wishlist!.length : 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 16,
                    childAspectRatio: (200 / 300),
                  ),
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) => WishlistItem(
                    imageUrl:
                        snapshot.data!.wishlist![index].product!.imageUrl!,
                    itemName: snapshot.data!.wishlist![index].product!.name!,
                    itemPrice:
                        snapshot.data!.wishlist![index].product!.price!.toInt(),
                    productId: snapshot.data!.wishlist![index].product!.id!,
                    onUpdate: updateScreen,
                  ),
                );
        },
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
  final int productId;
  final VoidCallback onUpdate;

  WishlistItem(
      {required this.imageUrl,
      required this.itemName,
      required this.itemPrice,
      required this.productId,
      required this.onUpdate});

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
                  Image.network(
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                    "${ApiClient.baseUrl}${imageUrl}",
                    fit: BoxFit.cover,
                    width: double
                        .infinity, // Ensure the image covers the full width
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () async {
                        var res = await ApiClient.removeFromWishlist(productId);
                        if (res) {
                          onUpdate();
                          showSnackBarSuccess(
                              context, 'Product remove from wishlist');
                        }
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  onPressed: () async {
                    // Add to cart logic
                    var res = await ApiClient.addToCart(context, productId);
                    if (res) {
                      var res = await ApiClient.removeFromWishlist(productId);
                      if (res) {
                        onUpdate();
                        showSnackBarSuccess(context, 'Product added to cart');
                      }
                    }
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
