/* 
*  Application: KHAATA
*  Status: ALPHA
*  Version: 1.0.3
*  Description: project description here . . .
* 
*  Developers:
*   Liaqat Ali    (CEO)
*   Alyaan Sohail (Lead Programmer)
*   Zaheer        (Programmer)
*   Kazim         (Programmer)
*   Aimal         (Programmer)
*   Jaanas        (Programmer)
*   Fahad Zia     (Programmer)
*/

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
  Hive.init((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());

  userBox = await Hive.openBox<Customer>('user_box');
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouteGenerator.generate,
      initialRoute: '/OrderScreen',
    ),
  );
}
