import 'package:hive/hive.dart';
import 'package:khata/models/model/user_model.dart';
part '../adapters/order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? totalCost;

  @HiveField(2)
  UserModel? userModel;

  OrderModel(
      {required this.id, required this.userModel, required this.totalCost});
}
