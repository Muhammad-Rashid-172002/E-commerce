import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/views/screens/home/constant/shop_item_model.dart';

class SellProductScreen extends StatefulWidget {
  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  ShopItem? selectedItem;
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Make sure to use the correct box name 'shopItems'
    final boxName = 'shopItems';

    // You could add a check here if needed, but usually the box should be opened before navigating here
    final items = Hive.isBoxOpen(boxName)
        ? Hive.box<ShopItem>(boxName).values.toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Product"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Card(
                color: Colors.green.shade50,
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
                      DropdownButtonFormField<String>(
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
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item.productName,
                                child: Text(item.productName),
                              ),
                            )
                            .toList(),
                        value: selectedItem?.productName,
                        onChanged: (val) {
                          setState(() {
                            selectedItem = items.firstWhere(
                              (item) => item.productName == val,
                            );
                          });
                        },
                      ),

                      SizedBox(height: 15),
                      TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity to Sell',
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
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  final qty = int.tryParse(quantityController.text.trim()) ?? 0;

                  if (selectedItem != null &&
                      qty > 0 &&
                      selectedItem!.quantity >= qty) {
                    setState(() {
                      selectedItem!.quantity -= qty;
                      selectedItem!.totalSold += qty;
                      selectedItem!.save();
                    });

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Sale recorded')));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid or insufficient quantity'),
                      ),
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
      ),
    );
  }
}
