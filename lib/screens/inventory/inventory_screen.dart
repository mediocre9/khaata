import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:khata/screens/inventory/search_item.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';

class ManageInventoryScreen extends StatelessWidget {
  const ManageInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            title: "Manage", titleFontSize: 23, subTitle: "Inventory"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AddItemButtonPane(),
                SearchItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// add item navigator button....
class AddItemButtonPane extends StatelessWidget {
  const AddItemButtonPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onHover: null,
          onPressed: () {
            Navigator.pushNamed(context, Routes.kAddItemSubScreen);
          },
          label: const Text("ADD ITEM", style: TextStyle(color: kTextColor)),
          icon: const Icon(Icons.add, color: kTextColor),
        )
      ],
    );
  }
}
