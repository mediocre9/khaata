import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/routes/route_generator.dart';
// import 'package:khata/routes/route_generator.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  // TODO: lazyBox implementation......
  userBox = await Hive.openBox<UserModel>('user_box');
  productBox = await Hive.openBox<ProductModel>('product_box');
  orderBox = await Hive.openBox<OrderModel>('order_box');

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: true,
      initialRoute: Routes.kManageFinanceScreen,
      onGenerateRoute: AppRouteGenerator.generateScreen,
    ),
  );
}
