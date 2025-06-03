import 'package:flutter/material.dart';

class SellProductScreen extends StatelessWidget {
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sell Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              items: [DropdownMenuItem(child: Text('Pen'), value: 'Pen')],
              onChanged: (val) {},
              decoration: InputDecoration(labelText: 'Select Product'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity to Sell'),
            ),
            SizedBox(height: 24),
            Text('Total = ₹', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: Text('Confirm Sale'),
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
