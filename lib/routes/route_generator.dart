import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/screens/completed_screen/cubit/completed_cubit.dart';
import 'package:khata/screens/completed_screen/presentation/completed_screen.dart';
import 'package:khata/screens/finance_screen/finance_screen.dart';
import 'package:khata/screens/inventory_screen/cubit/inventory_cubit.dart';
import 'package:khata/screens/inventory_screen/presentation/inventory_screen.dart';
import 'package:khata/screens/inventory_screen/sub_screens/add_item_screen/cubit/add_item_cubit.dart';
import 'package:khata/screens/inventory_screen/sub_screens/add_item_screen/presentation/add_item_screen.dart';
import 'package:khata/screens/order_screen/cubit/order_cubit.dart';
import 'package:khata/screens/order_screen/presentation/order_screen.dart';
import 'package:khata/screens/order_screen/sub_screens/add_order_screen/cubit/add_order_cubit.dart';
import 'package:khata/screens/order_screen/sub_screens/add_order_screen/presentation/add_order_screen.dart';
import 'package:khata/screens/pending_screen/cubit/pending_cubit.dart';
import 'package:khata/screens/pending_screen/presentation/pending_screen.dart';
import 'package:khata/screens/user_screen/add_customer_screen/cubit/add_customer_cubit.dart';
import 'package:khata/screens/user_screen/add_customer_screen/presentation/add_customer_screen.dart';
import 'package:khata/screens/user_screen/cubit/customer_cubit.dart';
import 'package:khata/screens/user_screen/presentation/customer_screen.dart';

class AppRouteGenerator {
  static Route<dynamic> generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/UserScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => UserCubit(),
            child: const CustomerScreen(),
          ),
        );

      case '/AddUserScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => AddUserCubit(),
            child: const AddCustomerScreen(),
          ),
        );

      case '/InventoryScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => InventoryCubit(),
            child: const InventoryScreen(),
          ),
        );

      case '/AddItemScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => AddItemCubit(),
            child: const AddItemScreen(),
          ),
        );

      case '/PendingScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => PendingCubit(),
            child: const PendingScreen(),
          ),
        );

      case '/CompletedScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => CompletedCubit(),
            child: const CompletedScreen(),
          ),
        );

      case '/OrderScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => OrderCubit(),
            child: const OrderScreen(),
          ),
        );

      case '/AddOrderScreen':
        return _pageRoute(
          BlocProvider(
            create: (context) => AddOrderCubit(),
            child: const AddOrderScreen(),
          ),
        );

      case '/FinanceScreen':
        return _pageRoute(const FinanceScreen());

      default:
        return _pageRoute(_undefinedRouteScreen);
    }
  }

  static _pageRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
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
