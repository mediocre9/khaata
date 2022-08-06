import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
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
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Order",
          titleFontSize: 23,
          subTitle: "Book",
        ),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: CustomCard(
            innerMainAlignment: MainAxisAlignment.center,
            width: double.maxFinite,
            height: double.maxFinite,
            verticalMargin: 50,
            horizontalMargin: 30,
            elevationLevel: 5,
            borderRadius: 5,
            child: Column(
              children: [
                const Text(
                  "ADD USER",
                  style: TextStyle(
                      color: kCardTextColor,
                      fontSize: 20,
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
          const Text("NAME",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: _usernameController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.name,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 45),
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
          const SizedBox(height: 45),
          Center(
            child: CustomOutlinedButton(
              textColor: kCardTextColor,
              onPressed: () {
                _saveDataToDatabase(context);
              },
              text: "ADD TO USER LIST",
            ),
          )
        ],
      ),
    );
  }

  void _saveDataToDatabase(BuildContext context) {
    if (_usernameController.text.isEmpty || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(_showErrorSnackBar());
    } else {
      var user = UserModel(
        username: _usernameController.text,
        address: _addressController.text,
      );
      userBox!.add(user);
      ScaffoldMessenger.of(context).showSnackBar(_showSuccessSnackBar());
      _usernameController.clear();
      _addressController.clear();
    }
  }

  SnackBar _showSuccessSnackBar() {
    return SnackBar(
      key: UniqueKey(),
      content: const Text("User has been addded successfully!",
          style: TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: kSnackBarSuccessColor,
    );
  }

  SnackBar _showErrorSnackBar() {
    return SnackBar(
      key: UniqueKey(),
      content: const Text("Please fill all the required fields!",
          style: TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: kSnackBarErrorColor,
    );
  }
}
