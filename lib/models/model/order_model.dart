import 'package:hive/hive.dart';
part '../adapters/order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel {
  @HiveField(0)
  final String? username;

  @HiveField(1)
  final String? productname;

  @HiveField(2)
  final int? cost;

  @HiveField(3)
  final DateTime? createdDate;

  @HiveField(4)
  final DateTime? completedDate;

  @HiveField(5)
  final bool? status;

  OrderModel(this.username, this.productname, this.cost, this.createdDate,
      this.completedDate, this.status);
}
