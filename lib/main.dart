import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:khata/themes/themes.dart';
import 'package:path_provider/path_provider.dart';

/// [Hive] database.
/// For futher details, please refer to the documentation.
/// Documentation: https://docs.hivedb.dev/#/
Future<void> initDatabase() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());

  userBox = await Hive.openBox<UserModel>('user_box');
  productBox = await Hive.openBox<ProductModel>('product_box');
  orderBox = await Hive.openBox<OrderModel>('order_box');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();

  runApp(
    MaterialApp(
      title: "Khaata",
      color: Colors.white30,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      onGenerateRoute: AppRouteGenerator.generate,
      initialRoute: '/OrderScreen',
    ),
  );
}
