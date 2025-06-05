import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/views/screens/home/constant/shop_item_model.dart';
import 'package:shop_app/views/screens/home/homescreen.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final buyRateController = TextEditingController();
  final sellRateController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    buyRateController.dispose();
    sellRateController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    final name = nameController.text.trim();
    final buy = double.tryParse(buyRateController.text.trim()) ?? 0.0;
    final sell = double.tryParse(sellRateController.text.trim()) ?? 0.0;
    final qty = int.tryParse(qtyController.text.trim()) ?? 0;

    if (name.isNotEmpty && qty > 0 && buy > 0 && sell > 0) {
      final item = ShopItem(
        productName: name,
        quantity: qty,
        buyRate: buy,
        sellRate: sell,
        totalSold: 0,
        customerName: null,
        totalPrice: null,
        date: null,
      );

      try {
        final box = Hive.box<ShopItem>('products');
        await box.add(item);

        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Product added successfully')));

        // Navigate back to home or product overview screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProductsOverviewScreen()),
        );
      } catch (e) {
        print('Error saving product: $e');
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save product')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid product details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
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
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              onPressed: _saveProduct,
              child: Text(
                "Save Product",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
