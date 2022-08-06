import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';
import 'package:khata/widgets/custom_text_field.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

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
        body: CustomCard(
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
                "ADD ITEM",
                style: TextStyle(
                    color: kCardTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const SaveItemData())
            ],
          ),
        ),
      ),
    );
  }
}

class SaveItemData extends StatelessWidget {
  const SaveItemData({Key? key}) : super(key: key);
  static final TextEditingController _itemNameController =
      TextEditingController();
  static final TextEditingController _stockControlller =
      TextEditingController();

  static final TextEditingController _costController = TextEditingController();

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
            controller: _itemNameController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.name,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 35),
          const Text("INITIAL STOCK",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: _stockControlller,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.number,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 35),
          const Text("COST",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: _costController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.number,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 35),
          Center(
            child: CustomOutlinedButton(
              textColor: kCardTextColor,
              onPressed: () {},
              text: "ADD ITEM",
            ),
          )
        ],
      ),
    );
  }
}
