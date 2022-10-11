import 'package:hive/hive.dart';
part '../adapters/customer.g.dart';

@HiveType(typeId: 0)
class Customer {
  @HiveField(0)
  final String? username;

  @HiveField(1)
  final String? address;

  Customer({
    this.username,
    this.address,
  });
}
