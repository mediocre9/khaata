import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part '../adapters/product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? stock;

  @HiveField(2)
  int? cost;

  Product({required this.name, required this.stock, required this.cost});
}
