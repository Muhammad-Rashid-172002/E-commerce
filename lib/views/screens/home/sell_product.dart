import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/views/screens/home/constant/product_model.dart';

class SellProductScreen extends StatefulWidget {
  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  Product? selectedProduct;
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = Hive.box<Product>('products').values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Sell Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 80),
            Card(
              color: Colors.green.shade50, // subtle light green background
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<Product>(
                      decoration: InputDecoration(
                        labelText: 'Select Product',
                        labelStyle: TextStyle(color: Colors.green.shade900),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: products
                          .map(
                            (prod) => DropdownMenuItem(
                              value: prod,
                              child: Text(prod.name),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => selectedProduct = val),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(color: Colors.green.shade900),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: () {
                final qty = int.tryParse(quantityController.text.trim()) ?? 0;
                if (selectedProduct != null &&
                    qty > 0 &&
                    selectedProduct!.quantity >= qty) {
                  selectedProduct!.quantity -= qty;
                  selectedProduct!.totalSold += qty;
                  selectedProduct!.save();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Sale recorded')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid or insufficient quantity')),
                  );
                }
              },
              child: Text(
                "Confirm Sale",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
