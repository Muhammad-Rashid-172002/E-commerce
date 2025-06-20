// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopItemAdapter extends TypeAdapter<ShopItem> {
  @override
  final int typeId = 2;

  @override
  ShopItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopItem(
      productName: fields[0] as String,
      quantity: fields[1] as int,
      buyRate: fields[2] as double,
      sellRate: fields[3] as double,
      totalSold: fields[4] as int,
      customerName: fields[5] as String?,
      totalPrice: fields[6] as double?,
      date: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ShopItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.buyRate)
      ..writeByte(3)
      ..write(obj.sellRate)
      ..writeByte(4)
      ..write(obj.totalSold)
      ..writeByte(5)
      ..write(obj.customerName)
      ..writeByte(6)
      ..write(obj.totalPrice)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
