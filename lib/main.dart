import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/views/screens/home/constant/product_model.dart';
import 'package:shop_app/views/screens/home/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(ProductAdapter());

  // Open box
  await Hive.openBox<Product>('products');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      home: Splashscreen(),
    );
  }
}
