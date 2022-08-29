import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/screens/add_order_screen/add_order_screen.dart';
import 'package:khata/screens/finance_screen/finance_screen.dart';
import 'package:khata/screens/intro_screen/intro_screen.dart';
import 'package:khata/screens/inventory_home_screen/cubit/inventory_home_cubit.dart';
import 'package:khata/screens/inventory_home_screen/inventory_home_screen.dart';
import 'package:khata/screens/add_item_screen/add_item_screen.dart';
import 'package:khata/screens/order_completed_screen/order_completed_screen.dart';
import 'package:khata/screens/order_pending_screen/cubit/pending_order_cubit.dart';
import 'package:khata/screens/order_pending_screen/order_pending_screen.dart';
import 'package:khata/screens/order_screen/cubit/order_home_cubit.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/screens/user_home_screen/cubit/user_home_cubit.dart';
import 'package:khata/screens/user_home_screen/user_home_screen.dart';

// Implemented routing system for future use and scalability.
// if we want to build a web application from this codebase...
class Routes {
  static const kHomeScreen = '/';
  static const kSplashScreen = '/splashScreen';
  static const kIntroScreen = '/introScreen';
  static const kManageUserScreen = '/manageUserScreen';
  static const kManageOrderScreen = '/manageOrderScreen';
  static const kManageFinanceScreen = '/manageFinanceScreen';
  static const kManageInventoryScreen = '/manageInventoryScreen';
  static const kSettingScreen = '/settingScreen';
  static const kAboutScreen = '/aboutScreen';
  static const kPendingScreen = '/pendingScreen';
  static const kCompletedScreen = '/completedScreen';
  static const kAddUserSubScreen = '/addUserScreen';
  static const kAddItemSubScreen = '/addItemScreen';
  static const kAddOrderSubScreen = '/addOrderScreen';
}

class AppRouteGenerator {
  static Route<dynamic> generateScreen(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/introScreen':
        return pageRoute(const IntroScreen());

      case '/manageUserScreen':
        return pageRoute(BlocProvider(
          create: (context) => UserHomeCubit(),
          child: UserHomeScreen(),
        ));

      case '/manageInventoryScreen':
        return pageRoute(BlocProvider(
          create: (context) => InventoryHomeCubit(),
          child: InventoryHomeScreen(),
        ));

      case '/pendingScreen':
        return pageRoute(BlocProvider(
          create: (context) => PendingOrderCubit(),
          child: const OrderPendingScreen(),
        ));

      case '/completedScreen':
        return pageRoute(const OrderCompletedScreen());

      case '/addItemScreen':
        return pageRoute(const AddItemScreen());

      case '/manageOrderScreen':
        return pageRoute(BlocProvider(
          create: (context) => OrderHomeCubit(),
          child: const ManageOrderScreen(),
        ));

      case '/addOrderScreen':
        return pageRoute(const AddOrderScreen());

      case '/manageFinanceScreen':
        return pageRoute(const FinanceScreen());

      default:
        return pageRoute(_undefinedRouteScreen);
    }
  }

  static pageRoute(dynamic screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }

  static get _undefinedRouteScreen {
    return const Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Text("UNDEFINED ROUTE",
            style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
