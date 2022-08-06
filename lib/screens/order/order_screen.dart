import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';
import 'package:khata/widgets/custom_text_field.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "ADD ORDER",
              style: TextStyle(
                  color: kCardTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: const SaveOrderData())
          ],
        ),
      ),
    );
  }
}

class SaveOrderData extends StatelessWidget {
  const SaveOrderData({Key? key}) : super(key: key);
  static final TextEditingController _idController = TextEditingController();
  static final TextEditingController _usernameController =
      TextEditingController();

  static final TextEditingController _totalCostController =
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
          const Text("ID",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: _idController,
            contentPadding: 10,
            color: kCardTextColor,
            inputType: TextInputType.number,
            borderStyle: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            onChanged: (s) {},
            isDense: true,
          ),
          const SizedBox(height: 35),
          const Text("USERNAME",
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
          const SizedBox(height: 35),
          const Text("TOTAL COST",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          CustomTextField(
            controller: _totalCostController,
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
              onPressed: () {},
              text: "ADD ORDER",
            ),
          )
        ],
      ),
    );
  }
}
