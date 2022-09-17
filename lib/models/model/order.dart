import 'package:hive/hive.dart';
part '../adapters/order.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  final String? customerName;

  @HiveField(1)
  final String? productName;

  @HiveField(2)
  final int? cost;

  @HiveField(3)
  final DateTime? createdDate;

  @HiveField(4)
  final DateTime? completedDate;

  @HiveField(5)
  final bool? pendingStatus;

  Order(this.customerName, this.productName, this.cost, this.createdDate,
      this.completedDate, this.pendingStatus);
}
