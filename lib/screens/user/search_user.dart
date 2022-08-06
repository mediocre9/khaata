import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_text_field.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            borderRadius: 4,
            isDense: true,
            contentPadding: 8,
            onChanged: (searchUser) {
              // _searchedUsers = mockedData
              //     .where((user) => user.username
              //         .toLowerCase()
              //         .contains(searchUser.toLowerCase()))
              //     .toList();
              // setState(() {});
            },
            controller: null,
          ),
        ],
      ),
    );
  }
}
