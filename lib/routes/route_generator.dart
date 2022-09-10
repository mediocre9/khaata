import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/screens/add_item_screen/cubit/add_item_cubit.dart';
import 'package:khata/screens/add_order_screen/add_order_screen.dart';
import 'package:khata/screens/add_order_screen/cubit/add_order_cubit.dart';
import 'package:khata/screens/finance_screen/finance_screen.dart';
import 'package:khata/screens/inventory_home_screen/cubit/inventory_home_cubit.dart';
import 'package:khata/screens/inventory_home_screen/inventory_home_screen.dart';
import 'package:khata/screens/add_item_screen/add_item_screen.dart';
import 'package:khata/screens/order_completed_screen/cubit/order_complete_cubit.dart';
import 'package:khata/screens/order_completed_screen/order_completed_screen.dart';
import 'package:khata/screens/order_pending_screen/cubit/pending_order_cubit.dart';
import 'package:khata/screens/order_pending_screen/order_pending_screen.dart';
import 'package:khata/screens/order_screen/cubit/order_home_cubit.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/screens/user_add_screen/cubit/user_add_cubit.dart';
import 'package:khata/screens/user_add_screen/user_add_sub_screen.dart';
import 'package:khata/screens/user_home_screen/cubit/user_home_cubit.dart';
import 'package:khata/screens/user_home_screen/user_home_screen.dart';

// Implemented routing system for future use and scalability.
// if we want to build a web application from this codebase...
class AppRouteGenerator {
  static Route<dynamic> generateScreen(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/manageUserScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => UserHomeCubit(),
            child: const UserHomeScreen(),
          ),
        );

      case '/manageInventoryScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => InventoryHomeCubit(),
            child: const InventoryHomeScreen(),
          ),
        );

      case '/pendingScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => PendingOrderCubit(),
            child: const OrderPendingScreen(),
          ),
        );

      case '/completedScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => OrderCompleteCubit(),
            child: const OrderCompletedScreen(),
          ),
        );

      case '/addItemScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => AddItemCubit(),
            child: const AddItemScreen(),
          ),
        );

      case '/addUserScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => UserAddCubit(),
            child: const UserAddSubScreen(),
          ),
        );

      case '/manageOrderScreen':
        return pageRoute(
          BlocProvider(
            create: (context) => OrderHomeCubit(),
            child: const ManageOrderScreen(),
          ),
        );

      case '/addOrderScreen':
        return pageRoute(BlocProvider(
          create: (context) => AddOrderCubit(),
          child: const AddOrderScreen(),
        ));

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
        child: Text(
          "UNDEFINED ROUTE",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
