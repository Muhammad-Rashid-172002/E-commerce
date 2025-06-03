import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/home/add_product.dart';
import 'package:shop_app/views/screens/home/dummy.dart';
import 'package:shop_app/views/screens/home/sell_product.dart';

class HomeScreen extends StatelessWidget {
  Widget buildTile(String title, String value) => Expanded(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                buildTile("Products", "12"),
                SizedBox(width: 16),
                buildTile("In Stock", "100"),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                buildTile("Total Sales", "₹5,000"),
                SizedBox(width: 16),
                buildTile("Profit", "₹1,200"),
              ],
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                homeButton(
                  context,
                  "Add Product",
                  Icons.add,
                  AddProductScreen(),
                ),
                homeButton(
                  context,
                  "Sell Product",
                  Icons.shopping_cart,
                  SellProductScreen(),
                ),
                homeButton(
                  context,
                  "View Reports",
                  Icons.bar_chart,
                  DummyScreen("Reports"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget homeButton(
    BuildContext context,
    String label,
    IconData icon,
    Widget screen,
  ) {
    return ElevatedButton.icon(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(140, 50),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
