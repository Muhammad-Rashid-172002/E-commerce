import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/views/screens/home/constant/product_model.dart';
import 'package:shop_app/views/screens/home/dummy.dart';
import 'add_product.dart';
import 'sell_product.dart';

class HomeScreen extends StatelessWidget {
  int getTotalProducts(Box<Product> box) => box.length;

  int getTotalStock(Box<Product> box) =>
      box.values.fold(0, (a, b) => a + b.quantity);

  double getTotalSales(Box<Product> box) =>
      box.values.fold(0, (a, b) => a + b.totalSold * b.sellRate);

  double getProfit(Box<Product> box) =>
      box.values.fold(0, (a, b) => a + b.totalSold * (b.sellRate - b.buyRate));

  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box<Product>('products');

    return Scaffold(
      appBar: AppBar(title: Text('Home'), backgroundColor: Colors.blueAccent),
      body: ValueListenableBuilder(
        valueListenable: productBox.listenable(),
        builder: (context, Box<Product> box, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    buildTile("Products", getTotalProducts(box).toString()),
                    SizedBox(width: 16),
                    buildTile("In Stock", getTotalStock(box).toString()),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    buildTile(
                      "Total Sales",
                      'Rs ${getTotalSales(box).toStringAsFixed(2)}',
                    ),
                    SizedBox(width: 16),
                    buildTile(
                      "Profit",
                      'Rs ${getProfit(box).toStringAsFixed(2)}',
                    ),
                  ],
                ),
                SizedBox(height: 120),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    homeButton(
                      context,
                      "Add Product",
                      Icons.add,
                      AddProductScreen(),
                      Colors.green, // Green color for Add Product
                    ),
                    homeButton(
                      context,
                      "Sell Product",
                      Icons.sell,
                      SellProductScreen(),
                      Colors.orange, // Orange color for Sell Product
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTile(String title, String value) => Expanded(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    ),
  );

  Widget homeButton(
    BuildContext context,
    String text,
    IconData icon,
    Widget screen,
    Color color,
  ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }
}
