import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController purchaseRateController = TextEditingController();
  final TextEditingController sellingRateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: purchaseRateController,
              decoration: InputDecoration(labelText: 'Purchase Rate (₹)'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: sellingRateController,
              decoration: InputDecoration(labelText: 'Selling Rate (₹)'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Initial Quantity'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save Product'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
