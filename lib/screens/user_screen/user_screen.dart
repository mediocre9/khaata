import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/screens/add_user_screen/add_user_screen.dart';
import 'package:khata/screens/add_user_screen/bloc/add_user_bloc.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

class ManageUserScreen extends StatefulWidget {
  const ManageUserScreen({Key? key}) : super(key: key);

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  static List<UserModel?> searchList = [];
  static List<UserModel?> userList = [];

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  fetchAllData() {
    userList.clear();
    for (var i = 0; i < userBox!.values.length; i++) {
      userList.add(userBox!.getAt(i));
    }
    searchList = userList;
  }

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
              children: [
                const AddUserButtonPane(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "SEARCH USER",
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                            ),
                          ),
                          Icon(Icons.search_rounded, size: 14)
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                        hintText: "Search",
                        borderRadius: 4,
                        isDense: true,
                        contentPadding: 8,
                        onChanged: (searchUser) {
                          searchList = userList
                              .where((user) => user!.username!
                                  .toLowerCase()
                                  .contains(searchUser.toLowerCase()))
                              .toList();
                          setState(() {});
                        },
                        controller: null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: searchList.isNotEmpty
                      ? UsersFound(searchList: searchList)
                      : const UserNotFound(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchList.clear();
    userList.clear();
  }
}

class UsersFound extends StatelessWidget {
  const UsersFound({
    Key? key,
    required this.searchList,
  }) : super(key: key);

  final List<UserModel?> searchList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 17),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: searchList.length,
        itemBuilder: (_, index) {
          return UserCard(
            username: searchList[index]!.username,
            address: searchList[index]!.address,
          );
        },
      ),
    );
  }
}

class UserNotFound extends StatelessWidget {
  const UserNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search_off_rounded,
            color: Colors.grey,
            size: 65,
          ),
          Text("USER NOT FOUND!",
              style: TextStyle(color: Colors.grey, fontSize: 20))
        ],
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AddUserBloc(),
                  child: const AddUserScreen(),
                ),
              ),
            );
          },
          label: const Text("ADD USER", style: TextStyle(color: kTextColor)),
          icon: const Icon(Icons.add, color: kTextColor),
        )
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.username, required this.address})
      : super(key: key);
  final String? username, address;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: CustomCard(
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                username!,
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  color: kCardTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              dense: true,
              subtitle: Text(
                address!,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: kCardTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
