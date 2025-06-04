import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  double buyRate;

  @HiveField(3)
  double sellRate;

  @HiveField(4)
  int totalSold;

  Product({
    required this.name,
    required this.quantity,
    required this.buyRate,
    required this.sellRate,
    required this.totalSold,
  });
}
