import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/screens/add_user_screen/bloc/add_user_bloc.dart';
import 'package:khata/screens/add_user_screen/bloc/add_user_event.dart';
import 'package:khata/screens/user_screen/user_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';
import 'package:khata/widgets/custom_text_field.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Order",
          titleFontSize: 23,
          subTitle: "Book",
        ),

        // Drawer
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: CustomCard(
            innerMainAlignment: MainAxisAlignment.center,
            width: double.maxFinite,
            height: 310,
            verticalMargin: 10,
            horizontalMargin: 30,
            elevationLevel: 5,
            borderRadius: 5,
            child: Column(
              children: [
                const Text(
                  "ADD USER",
                  style: TextStyle(
                      color: kCardTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: const SaveUserData())
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

  static final TextEditingController _usernameController =
      TextEditingController();
  static final TextEditingController _addressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          const Text(
            "NAME",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextField(
            controller: _usernameController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.name,
            borderStyle: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 25),
          const Text(
            "ADDRESS",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          CustomTextField(
            controller: _addressController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.text,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 25),

          // outside scope activity listener or visit bloclibrary.dev documentation
          BlocListener<AddUserBloc, UserDataEntryState>(
            listener: (context, state) {
              if (state == UserDataEntryState.validState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  _showSnackBar("User has been successfully added!",
                      kSnackBarSuccessColor),
                );
                clearController();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageUserScreen(),
                    ),
                    (route) => false);
              }
            },
            child: BlocBuilder<AddUserBloc, UserDataEntryState>(
              builder: (context, state) {
                return Center(
                  child: CustomOutlinedButton(
                    textColor: kCardTextColor,
                    text: "ADD TO USER LIST",
                    onPressed: () {
                      BlocProvider.of<AddUserBloc>(context).add(
                        AddUserButtonEvent(
                          _usernameController.text,
                          _addressController.text,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void clearController() {
    _addressController.clear();
    _usernameController.clear();
  }

  SnackBar _showSnackBar(String? message, Color? color) {
    return SnackBar(
      key: UniqueKey(),
      content: Text(message ?? "Value not defined",
          style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color ?? Colors.blueAccent,
    );
  }
}
