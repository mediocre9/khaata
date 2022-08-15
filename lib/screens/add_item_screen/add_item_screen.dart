import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/screens/add_item_screen/bloc/add_item_bloc.dart';
import 'package:khata/screens/add_item_screen/bloc/add_item_event.dart';
import 'package:khata/screens/inventory_screen/inventory_screen.dart';
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
          subTitle: "Book",
          titleFontSize: 23,
        ),
        endDrawer: const CustomDrawer(),
        body: CustomCard(
          innerMainAlignment: MainAxisAlignment.center,
          verticalMargin: 15,
          horizontalMargin: 30,
          elevationLevel: 5,
          borderRadius: 5,
          height: 410,
          width: double.maxFinite,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.white60,
                      iconSize: 22,
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Text(
                "ADD ITEM",
                style: TextStyle(
                  fontSize: 20,
                  color: kCardTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: const SaveItemData(),
              ),
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
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("NAME",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                CustomTextField(
                  isDense: true,
                  contentPadding: 10,
                  color: kCardTextColor,
                  inputType: TextInputType.name,
                  controller: _itemNameController,
                  borderStyle: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3)),
                  onChanged: (s) {},
                ),
              ],
            ),
          ),
// separation
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "INITIAL STOCK",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextField(
                  isDense: true,
                  contentPadding: 10,
                  maxLength: 5,
                  counterStyle: Colors.white,
                  color: kCardTextColor,
                  controller: _stockControlller,
                  inputType: TextInputType.number,
                  borderStyle: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3),
                  ),
                  onChanged: (s) {},
                ),
              ],
            ),
          ),

          // separation
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "COST",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextField(
                  isDense: true,
                  contentPadding: 10,
                  maxLength: 5,
                  color: kCardTextColor,
                  counterStyle: Colors.white,
                  controller: _costController,
                  inputType: TextInputType.number,
                  borderStyle: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3),
                  ),
                  onChanged: (s) {},
                ),
              ],
            ),
          ),

          // separation
          BlocListener<ItemBloc, ItemState>(
            listener: (context, state) {
              if (state == ItemState.validState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  _showSnackBar("Item has been successfully added!",
                      kSnackBarSuccessColor),
                );
                clearController();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageInventoryScreen(),
                    ),
                    (route) => false);
              }
            },
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (BuildContext context, state) {
                return Center(
                  child: CustomOutlinedButton(
                    text: "ADD ITEM",
                    textColor: kCardTextColor,
                    onPressed: () {
                      BlocProvider.of<ItemBloc>(context).add(
                        AddItemButtonEvent(
                          _itemNameController.text,
                          int.parse(_stockControlller.text),
                          int.parse(_costController.text),
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
    _itemNameController.clear();
    _costController.clear();
    _stockControlller.clear();
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
