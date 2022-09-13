import 'package:hive/hive.dart';
part '../adapters/order.g.dart';

@HiveType(typeId: 2)
class Order {
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

  Order(this.username, this.productname, this.cost, this.createdDate,
      this.completedDate, this.status);
}
