import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/views/screens/home/constant/shop_item_model.dart';

import 'add_product.dart';
import 'sell_product.dart';

// Make sure ShopItemAdapter is registered before running app:
// Hive.registerAdapter(ShopItemAdapter());

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // Pages for bottom navigation
  final List<Widget> pages = [ProductsOverviewScreen(), UnpaidScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex == 0 ? 'Home' : 'Unpaid Items'),
        backgroundColor: Colors.blueAccent,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.money_off), label: 'Unpaid'),
        ],
      ),
    );
  }
}

// Products Overview Screen showing summaries and buttons
class ProductsOverviewScreen extends StatelessWidget {
  int getTotalProducts(Box<ShopItem> box) => box.length;

  int getTotalStock(Box<ShopItem> box) =>
      box.values.fold(0, (total, item) => total + item.quantity);

  double getTotalSales(Box<ShopItem> box) => box.values.fold(
    0,
    (total, item) => total + item.totalSold * item.sellRate,
  );

  double getProfit(Box<ShopItem> box) => box.values.fold(
    0,
    (total, item) => total + item.totalSold * (item.sellRate - item.buyRate),
  );

  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box<ShopItem>('shopItems');

    return ValueListenableBuilder(
      valueListenable: productBox.listenable(),
      builder: (context, Box<ShopItem> box, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  buildTile("Products", getTotalProducts(box).toString()),
                  const SizedBox(width: 16),
                  buildTile("In Stock", getTotalStock(box).toString()),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  buildTile(
                    "Total Sales",
                    'Rs ${getTotalSales(box).toStringAsFixed(2)}',
                  ),
                  const SizedBox(width: 16),
                  buildTile(
                    "Profit",
                    'Rs ${getProfit(box).toStringAsFixed(2)}',
                  ),
                ],
              ),
              const SizedBox(height: 120),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  homeButton(
                    context,
                    "Add Product",
                    Icons.add,
                    AddProductScreen(),
                    Colors.green,
                  ),
                  homeButton(
                    context,
                    "Sell Product",
                    Icons.sell,
                    SellProductScreen(),
                    Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }
}

// Screen showing unpaid ShopItems with non-null customerName
class UnpaidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unpaidBox = Hive.box<ShopItem>('shopItems');

    return ValueListenableBuilder(
      valueListenable: unpaidBox.listenable(),
      builder: (context, Box<ShopItem> box, _) {
        final unpaidItems = box.values
            .where((item) => item.customerName != null)
            .toList();

        if (unpaidItems.isEmpty) {
          return const Center(child: Text('No unpaid items found.'));
        }

        return ListView.builder(
          itemCount: unpaidItems.length,
          itemBuilder: (_, index) {
            final item = unpaidItems[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(item.productName),
                subtitle: Text(
                  'Customer: ${item.customerName}\nQuantity: ${item.quantity}\nTotal Price: Rs ${item.totalPrice?.toStringAsFixed(2) ?? 'N/A'}',
                ),
                trailing: item.date != null
                    ? Text(
                        '${item.date!.day}/${item.date!.month}/${item.date!.year}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
