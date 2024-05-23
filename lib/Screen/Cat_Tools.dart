import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('Tools'),
          actions: [
            Icon(Icons.search),
          ],
        ),
        body: ToolsPage(),
      ),
    );
  }
}

class ToolsPage extends StatelessWidget {
  final List<Item> items = [
    Item(name: 'Sapu Pembersih Lantai Fiber', price: 18000, image: 'assets/sapu.jpg'),
    Item(name: 'Drone', price: 8000000, image: 'assets/drone.jpg'),
    Item(name: 'Mouse Wireless', price: 80000, image: 'assets/mouse.jpg'),
    Item(name: 'Sofa Putih', price: 1300000, image: 'assets/sofa.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryButton(label: 'Stationary'),
              CategoryButton(label: 'Furniture'),
              CategoryButton(label: 'Tools'),
              CategoryButton(label: 'Attribute'),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(item: items[index]);
            },
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;

  CategoryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}

class Item {
  final String name;
  final int price;
  final String image;

  Item({required this.name, required this.price, required this.image});
}

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(item.image, fit: BoxFit.cover, height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Rp. ${item.price}',
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
