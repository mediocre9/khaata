import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
              icon: const Icon(
                Icons.home_sharp,
                color: kDrawerItemColor,
                size: 30,
              ),
              label: const Text(
                "HOME",
                style: TextStyle(color: kDrawerItemColor),
              ),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/UserScreen',
                (route) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerItems extends StatefulWidget {
  const CustomDrawerItems({Key? key}) : super(key: key);
  static List<String> drawerItems = [
    "Order",
    "Inventory",
    "Users",
    "Finance",
    "About",
  ];

  @override
  State<CustomDrawerItems> createState() => _CustomDrawerItemsState();
}

class _CustomDrawerItemsState extends State<CustomDrawerItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CustomDrawerItems.drawerItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ExpansionTile(
            collapsedIconColor: kDrawerItemColor,
            collapsedTextColor: kDrawerItemColor,
            initiallyExpanded: true,
            title: Text(
              CustomDrawerItems.drawerItems[0].toUpperCase(),
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
                CustomDrawerItems.drawerItems[index].toUpperCase(),
                style: const TextStyle(fontSize: kDrawerItemFontSize),
              ),
              onTap: () {
                switch (CustomDrawerItems.drawerItems[index].toUpperCase()) {
                  case 'INVENTORY':
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/InventoryScreen',
                      (route) => false,
                    );
                    break;

                  case 'USERS':
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/UserScreen',
                      (route) => false,
                    );
                    break;

                  case 'FINANCE':
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/FinanceScreen',
                      (route) => false,
                    );
                    break;

                  case 'ABOUT':
                    showAboutDialog(
                      context: context,
                      applicationIcon: const FlutterLogo(),
                    );
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

  static int get _pendingOrders {
    int count = 0;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus! == true) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 2,
            color: kDrawerItemColor,
          ),
        ),
      ),
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
                title: (index == 1 && _pendingOrders > 0
                    ? Badge(
                        alignment: Alignment.centerLeft,
                        badgeContent: Text(_pendingOrders.toString()),
                        child: Text(
                          subItems[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : Text(subItems[index])),
                textColor: kDrawerItemColor,
                onTap: () {
                  switch (subItems[index].toUpperCase()) {
                    case 'MANAGE':
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/OrderScreen',
                        (route) => false,
                      );
                      break;
                    case 'PENDING':
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/PendingScreen',
                        (route) => false,
                      );
                      break;

                    case 'COMPLETED':
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/CompletedScreen',
                        (route) => false,
                      );
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
