import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

import '../cubit/add_user_cubit.dart';
import '../cubit/add_user_state.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: Text("Order"), subtitle: Text("Book")),

        // Drawer
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: CustomCard(
            innerMainAlignment: MainAxisAlignment.center,
            width: double.maxFinite,
            height: 310,
            verticalMargin: 3,
            horizontalMargin: 30,
            elevationLevel: 5,
            borderRadius: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.white60,
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/UserScreen');
                      },
                    ),
                  ],
                ),
                const Text(
                  "ADD USER",
                  style: TextStyle(color: kCardTextColor, fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SaveUserData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SaveUserData extends StatelessWidget {
  const SaveUserData({Key? key}) : super(key: key);

  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.zero,
      child: BlocListener<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is UserAddedState) {
            _clearController();
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(state.message, state.color));
          } else if (state is UserNotAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(state.message, state.color));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "NAME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: _username,
              contentPadding: 10,
              color: kCardTextColor,
              inputType: TextInputType.name,
              // borderStyle: const UnderlineInputBorder(
              //   borderSide: BorderSide(
              //     color: Colors.white,
              //     width: 3,
              //   ),
              // ),
              onChanged: (s) {},
              isDense: true,
            ),
            const SizedBox(height: 20),
            const Text(
              "ADDRESS",
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            CustomTextField(
              controller: _address,
              contentPadding: 10,
              color: kCardTextColor,
              inputType: TextInputType.text,
              // borderStyle: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: Colors.white, width: 3)),
              onChanged: (s) {},
              isDense: true,
            ),
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                // textColor: kCardTextColor,
                child: const Text("ADD USER"),
                onPressed: () {
                  BlocProvider.of<AddUserCubit>(context).addUser(_username.text, _address.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearController() {
    _address.clear();
    _username.clear();
  }

  SnackBar _showSnackBar(String? message, Color? color) {
    return SnackBar(
      key: UniqueKey(),
      content: Text(message ?? "Value not defined", style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color ?? Colors.blueAccent,
      duration: const Duration(seconds: 1),
    );
  }
}
