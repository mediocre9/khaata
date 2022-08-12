import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part '../adapters/product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? initialStock;

  @HiveField(2)
  int? cost;

  ProductModel(
      {required this.name, required this.initialStock, required this.cost});
}
