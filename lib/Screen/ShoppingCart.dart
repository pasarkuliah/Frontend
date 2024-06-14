import 'package:flutter/material.dart';
import 'package:nama_proyek/Screen/BillingInfo.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/globals.dart';
import 'package:nama_proyek/resposne/cart_response.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int totalPrice = 0; // Tambahkan variabel totalPrice

  List<Cart> cartItems = [];
  bool isLoading = true;

  Future<void> _updateCart() async {
    setState(() {});
  }

  Future getCart() async {
    var res = await ApiClient.getCart(context);
    if (res!.data != null) {
      setState(() {
        cartItems = res.data!.cart!;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : cartItems.isEmpty
              ? Center(
                  child: Text('cart is empty'),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: cartItems!.length,
                  itemBuilder: (context, index) => ShoppingCartItem(
                    imageUrl: cartItems[index].product!.imageUrl!,
                    itemName: cartItems[index].product!.name!,
                    itemPrice: 30000,
                    quantity: cartItems[index].quantity!,
                    productId: cartItems[index].product!.id!,
                    onUpdate: _updateCart,
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
      bottomSheet: TotalPriceWidget(
        totalPrice: totalPrice,
        onUpdate: _updateCart,
        cartItems: cartItems,
      ),
    );
  }
}

class TotalPriceWidget extends StatefulWidget {
  final int totalPrice;
  final VoidCallback onUpdate;
  final List<Cart> cartItems;

  TotalPriceWidget(
      {required this.totalPrice,
      required this.onUpdate,
      required this.cartItems});

  @override
  _TotalPriceWidgetState createState() => _TotalPriceWidgetState();
}

class _TotalPriceWidgetState extends State<TotalPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    BillingInformationScreen(cartItems: widget.cartItems),
              ));
            },
            child: Text('Checkout',
                style:
                    TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartItem extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;
  int quantity;
  int productId;
  final VoidCallback onUpdate; // Tambahkan properti onUpdate

  ShoppingCartItem(
      {required this.imageUrl,
      required this.itemName,
      required this.itemPrice,
      required this.quantity,
      required this.productId,
      required this.onUpdate}); // Tambahkan onUpdate ke konstruktor

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              "${ApiClient.baseUrl}${widget.imageUrl}",
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
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
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Price: Rp.${(widget.itemPrice * widget.quantity).toStringAsFixed(2)}', // Ubah menjadi total harga berdasarkan kuantitas
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
                          onPressed: () async {
                            // Handle quantity decrement
                            var res = await ApiClient.updateCartItemQuantity(
                                context, widget.productId, 'decrease');
                            if (res) {
                              widget
                                  .onUpdate(); // Panggil onUpdate untuk memperbarui tampilan
                              showSnackBarSuccess(
                                  context, 'success update quantity');
                            } else {
                              showSnackBarError(
                                  context, 'failed update quantity');
                            }
                          }),
                      Text(widget.quantity.toString()), // Tampilkan kuantitas
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () async {
                          // Handle quantity increment
                          var res = await ApiClient.updateCartItemQuantity(
                              context, widget.productId, 'increase');
                          if (res) {
                            widget
                                .onUpdate(); // Panggil onUpdate untuk memperbarui tampilan
                            showSnackBarSuccess(
                                context, 'success update quantity');
                          } else {
                            showSnackBarError(
                                context, 'failed update quantity');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                // Handle item removal
                var res =
                    await ApiClient.deleteFromChart(context, widget.productId);
                if (res) {
                  widget.onUpdate();
                  showSnackBarSuccess(context, 'success remove from cart');
                } else {
                  showSnackBarError(context, 'failed remove from cart');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
