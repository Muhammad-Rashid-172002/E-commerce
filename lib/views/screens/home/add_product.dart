import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/views/screens/home/constant/product_model.dart';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final buyRateController = TextEditingController();
  final sellRateController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Card(
                color: Colors.blue.shade50,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: buyRateController,
                        decoration: InputDecoration(
                          labelText: 'Buy Rate',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: sellRateController,
                        decoration: InputDecoration(
                          labelText: 'Sell Rate',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: qtyController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  final name = nameController.text.trim();
                  final buy =
                      double.tryParse(buyRateController.text.trim()) ?? 0.0;
                  final sell =
                      double.tryParse(sellRateController.text.trim()) ?? 0.0;
                  final qty = int.tryParse(qtyController.text.trim()) ?? 0;

                  if (name.isNotEmpty && qty > 0) {
                    final product = Product(
                      name: name,
                      buyRate: buy,
                      sellRate: sell,
                      quantity: qty,
                      totalSold: 0,
                    );
                    Hive.box<Product>('products').add(product);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter valid product details'),
                      ),
                    );
                  }
                },
                child: Text(
                  "Save Product",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
