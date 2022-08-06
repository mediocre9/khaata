import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/widgets/custom_card.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserRecordState();
}

class _UserRecordState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 17),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<UserModel>('user_box').listenable(),
          builder: (context, Box<UserModel> items, _) {
            userBox = items;
            return ListView.builder(
              itemCount: items.values.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return UserCard(
                    username: userBox!.getAt(index)!.username,
                    address: userBox!.getAt(index)!.address);
              },
            );
          },
        ),
      ),
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
              onTap: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              title: Text(
                username!,
                style: const TextStyle(
                    color: kCardTextColor,
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
              dense: true,
              subtitle: Text(
                address!,
                style: const TextStyle(
                  color: kCardTextColor,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
