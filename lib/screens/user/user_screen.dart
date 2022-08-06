import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:khata/screens/user/search_user.dart';
import 'package:khata/screens/user/user_list_view.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';

class ManageUserScreen extends StatelessWidget {
  const ManageUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            CustomAppBar(title: "Manage", titleFontSize: 23, subTitle: "User"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AddUserButtonPane(),
                SearchUser(),
                UserListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// user navigator button....
class AddUserButtonPane extends StatelessWidget {
  const AddUserButtonPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, Routes.kAddUserSubScreen),
          label: const Text("ADD USER", style: TextStyle(color: kTextColor)),
          icon: const Icon(Icons.add, color: kTextColor),
        )
      ],
    );
  }
}
