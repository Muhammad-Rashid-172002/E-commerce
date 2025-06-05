import 'package:hive/hive.dart';

part 'shop_item_model.g.dart';

@HiveType(typeId: 2)
class ShopItem extends HiveObject {
  @HiveField(0)
  String productName;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  double buyRate;

  @HiveField(3)
  double sellRate;

  @HiveField(4)
  int totalSold;

  @HiveField(5)
  String? customerName;

  @HiveField(6)
  double? totalPrice;

  @HiveField(7)
  DateTime? date;

  ShopItem({
    required this.productName,
    required this.quantity,
    required this.buyRate,
    required this.sellRate,
    required this.totalSold,
    this.customerName,
    this.totalPrice,
    this.date,
  });
}
