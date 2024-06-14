import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nama_proyek/api/apiclient.dart';
import 'package:nama_proyek/globals.dart';
import 'package:nama_proyek/resposne/category.dart';
import 'package:nama_proyek/resposne/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  List<Category> categories = [];
  List<Product> filteredProducts = [];

  String _selectedFilter = 'None';
  String _selectedSort = 'None';

  Future<void> geProducts() async {
    try {
      final response = await ApiClient.getProducts(context);
      if (products.isEmpty) {
        setState(() {
          products = response!.data!;
          filteredProducts = List.from(products);
        });
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void _searchProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _applyFilters();
    });
  }

  void _applyFilters() {
    if (_selectedFilter == 'Price Ascending') {
      filteredProducts.sort((a, b) => a.price!.compareTo(b.price!));
    } else if (_selectedFilter == 'Price Descending') {
      filteredProducts.sort((a, b) => b.price!.compareTo(a.price!));
    }

    if (_selectedSort == 'Name Ascending') {
      filteredProducts.sort((a, b) => a.name!.compareTo(b.name!));
    } else if (_selectedSort == 'Name Descending') {
      filteredProducts.sort((a, b) => b.name!.compareTo(a.name!));
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    geProducts();
  }

  void getCategories() async {
    var res = await ApiClient.getCategories(context);
    if (res != null) {
      setState(() {
        res.data!.forEach((element) {
          print(element.imageUrl);
        });
        categories = res.data!;
      });
    }
  }

  Future<void> _updateCart() async {
    products.clear();
    await geProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => geProducts(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: _searchProducts,
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
                        backgroundImage:
                            AssetImage('assets/images/profilee.jpg'),
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
                    'assets/images/bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 25,
                    ),
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            "/" + categories![index].name!,
                            arguments: categories[index]);
                      },
                      child: Column(
                        children: [
                          SvgPicture.network(
                            placeholderBuilder: (context) =>
                                Icon(Icons.warning_outlined),
                            '${ApiClient.baseUrl}${categories![index].imageUrl}',
                            width: 70,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                          Text(categories![index].name!)
                        ],
                      ),
                    ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        items: [
                          DropdownMenuItem(
                            value: 'None',
                            child: Text('No Filter'),
                          ),
                          DropdownMenuItem(
                            value: 'Price Ascending',
                            child: Text('Price Ascending'),
                          ),
                          DropdownMenuItem(
                            value: 'Price Descending',
                            child: Text('Price Descending'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        items: [
                          DropdownMenuItem(
                            value: 'None',
                            child: Text('No Sort'),
                          ),
                          DropdownMenuItem(
                            value: 'Name Ascending',
                            child: Text('Name Ascending'),
                          ),
                          DropdownMenuItem(
                            value: 'Name Descending',
                            child: Text('Name Descending'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSort = value!;
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                  childAspectRatio: (200 / 300),
                ),
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) => Container(
                  child: ProductItem(
                    imageUrl:
                        "${ApiClient.baseUrl}${filteredProducts[index].imageUrl}",
                    itemName: filteredProducts[index].name!,
                    itemPrice: filteredProducts[index].price!.toInt(),
                    productId: filteredProducts[index].id!,
                    wishlist: filteredProducts[index].wishlist!,
                    onUpdate: _updateCart,
                  ),
                ),
              ),
            ],
          ),
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

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final int itemPrice;
  final int productId;
  final bool wishlist;
  final VoidCallback onUpdate;

  ProductItem({
    required this.imageUrl,
    required this.itemName,
    required this.itemPrice,
    required this.productId,
    required this.wishlist,
    required this.onUpdate,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isAddingToWishlist = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  height: 200,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      if (widget.wishlist) {
                        var res = await ApiClient.removeFromWishlist(
                            widget.productId);
                        if (res) {
                          setState(() {
                            _isAddingToWishlist = false;
                          });
                          widget.onUpdate();
                          showSnackBarSuccess(
                              context, 'Product remove from wishlist');
                        }
                      } else {
                        setState(() {
                          _isAddingToWishlist = true;
                        });
                        var res =
                            await ApiClient.addToWishlist(widget.productId);
                        if (res) {
                          setState(() {
                            _isAddingToWishlist = false;
                          });
                          widget.onUpdate();
                          showSnackBarSuccess(
                              context, 'Product added to wishlist');
                        }
                      }
                    },
                    icon: _isAddingToWishlist
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.favorite,
                            color: widget.wishlist ? Colors.red : Colors.grey,
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: Text(
              widget.itemName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Rp. ${widget.itemPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                var res = await ApiClient.addToCart(context, widget.productId);
                if (res) {
                  widget.onUpdate();
                  showSnackBarSuccess(context, 'Product added to cart');
                }
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Add To Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
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
