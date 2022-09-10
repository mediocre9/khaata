import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
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
            CustomDrawerHeader(),
            CustomDrawerItems(),
            CustomDrawerFooter(),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

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
              icon: const Icon(Icons.home_sharp, color: kDrawerItemColor, size: 30),
              label: const Text("HOME", style: TextStyle(color: kDrawerItemColor)),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/manageUserScreen', (route) => false),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerItems extends StatelessWidget {
  const CustomDrawerItems({Key? key}) : super(key: key);
  static List<String> drawerItems = [
    "Order",
    "Inventory",
    "Users",
    "Finance",
    "About",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drawerItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ExpansionTile(
            collapsedIconColor: kDrawerItemColor,
            collapsedTextColor: kDrawerItemColor,
            initiallyExpanded: true,
            title: Text(
              drawerItems[0].toUpperCase(),
              style: const TextStyle(fontSize: kDrawerItemFontSize),
            ),
            children: const [
              DrawerSubItems(),
            ],
          );
        }
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: kDrawerSplashColor,
            child: ListTile(
              textColor: kDrawerItemColor,
              title: Text(
                drawerItems[index].toUpperCase(),
                style: const TextStyle(fontSize: kDrawerItemFontSize),
              ),
              onTap: () {
                switch (drawerItems[index].toUpperCase()) {
                  case 'INVENTORY':
                    Navigator.pushReplacementNamed(context, '/manageInventoryScreen');
                    break;

                  case 'USERS':
                    Navigator.pushNamedAndRemoveUntil(context, '/manageUserScreen', (route) => false);
                    break;

                  case 'FINANCE':
                    Navigator.pushNamedAndRemoveUntil(context, '/manageFinanceScreen', (route) => false);
                    break;

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
      decoration: const BoxDecoration(border: Border(left: BorderSide(width: 2, color: kDrawerItemColor))),
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
                title: Text(
                  subItems[index],
                  style: const TextStyle(fontSize: kDrawerSubItemFontSize),
                ),
                textColor: kDrawerItemColor,
                onTap: () {
                  switch (subItems[index].toUpperCase()) {
                    case 'MANAGE':
                      Navigator.pushReplacementNamed(context, '/manageOrderScreen');
                      break;
                    case 'PENDING':
                      Navigator.pushReplacementNamed(context, '/pendingScreen');
                      break;

                    case 'COMPLETED':
                      Navigator.pushNamedAndRemoveUntil(context, '/completedScreen', (route) => false);
                      break;
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

class CustomDrawerFooter extends StatelessWidget {
  const CustomDrawerFooter({Key? key}) : super(key: key);

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
