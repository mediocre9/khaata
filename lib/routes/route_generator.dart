import 'package:flutter/material.dart';
import 'package:khata/screens/inventory/inventory_screen.dart';
import 'package:khata/screens/order/order_screen.dart';
import 'package:khata/screens/intro/intro_screen.dart';
import 'package:khata/screens/inventory/sub_screen/add_item.dart';
import 'package:khata/screens/user/sub_screen/add_user.dart';
import 'package:khata/screens/user/user_screen.dart';

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
      case Routes.kIntroScreen:
        return pageRoute(const IntroScreen());

      case Routes.kManageUserScreen:
        return pageRoute(const ManageUserScreen());

      case Routes.kManageInventoryScreen:
        return pageRoute(const ManageInventoryScreen());

      case Routes.kAddUserSubScreen:
        return pageRoute(const AddUserScreen());

      case Routes.kAddItemSubScreen:
        return pageRoute(const AddItemScreen());

      case Routes.kAddOrderSubScreen:
        return pageRoute(const AddOrderScreen());

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
