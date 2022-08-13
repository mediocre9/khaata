import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:khata/screens/order_screen/order_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kBlueGradient, kTealGradient],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: const [
            DrawerHeader(),
            DrawerItems(),
            DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            textColor: kDrawerItemColor,
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: kDrawerItemColor,
              ),
              child: IconButton(
                color: Colors.blueGrey,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            iconColor: kDrawerItemColor,
            leading: TextButton.icon(
                icon: const Icon(Icons.home_sharp,
                    color: kDrawerItemColor, size: 30),
                label: const Text("HOME",
                    style: TextStyle(color: kDrawerItemColor)),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.kManageUserScreen, (route) => false)),
          ),
        ],
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({Key? key}) : super(key: key);
  static List<String> drawerItems = [
    "ORDERS",
    "SUBITEMS",
    "Inventory",
    "Users",
    "Finances",
    "Settings",
    "About",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drawerItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 1) {
          return const DrawerSubItems();
        }
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: kDrawerSplashColor,
            child: ListTile(
              textColor: kDrawerItemColor,
              title: Text(drawerItems[index].toUpperCase(),
                  style: const TextStyle(fontSize: kDrawerItemFontSize)),
              onTap: () {
                switch (drawerItems[index].toUpperCase()) {
                  case 'ORDERS':
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageOrderScreen(),
                        ),
                        (route) => false);
                    break;

                  case 'INVENTORY':
                    Navigator.pushNamedAndRemoveUntil(context,
                        Routes.kManageInventoryScreen, (route) => false);
                    break;

                  case 'USERS':
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kManageUserScreen, (route) => false);
                    break;
                  case 'FINANCE':
                  case 'ABOUT':
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class DrawerSubItems extends StatelessWidget {
  const DrawerSubItems({Key? key}) : super(key: key);
  static List<String> subItems = [
    "MANAGE",
    "PENDING",
    "COMPLETED",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: kDrawerItemColor))),
      child: ListView.builder(
        itemCount: subItems.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: const Color.fromRGBO(215, 216, 255, 1.0),
              child: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(subItems[index],
                    style: const TextStyle(fontSize: kDrawerSubItemFontSize)),
                textColor: kDrawerItemColor,
                onTap: () {
                  switch (subItems[index].toUpperCase()) {
                    case 'MANAGE':
                    case 'PENDING':
                    case 'COMPLETED':
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrawerFooter extends StatelessWidget {
  const DrawerFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: const Align(
          alignment: FractionalOffset.bottomCenter,
          child: Text(
            "SMART ALPHA SOFTWARE HOUSE",
            style: TextStyle(color: Color.fromRGBO(154, 188, 213, 1.0)),
          ),
        ),
      ),
    );
  }
}
