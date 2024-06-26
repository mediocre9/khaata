import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/models/model/customer.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:khata/themes/themes.dart';
import 'package:path_provider/path_provider.dart';

/// [Hive] database.
/// For futher details, please refer to the documentation.
/// Documentation: https://docs.hivedb.dev/#/
Future<void> initDatabase() async {
  if (kIsWeb) {
    Hive.initFlutter();
  } else {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());

  customerBox = await Hive.openBox<Customer>('customer_box');
  productBox = await Hive.openBox<Product>('product_box');
  orderBox = await Hive.openBox<Order>('order_box');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();

  runApp(
    MaterialApp(
      title: "Khaata",
      color: Colors.white30,
      theme: AppTheme.lightTheme(),
      initialRoute: '/OrderScreen',
      onGenerateRoute: AppRouteGenerator.generate,
      debugShowCheckedModeBanner: false,
    ),
  );
}
