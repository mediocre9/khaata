import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

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

class SaveOrderData extends StatefulWidget {
  const SaveOrderData({Key? key}) : super(key: key);
  static final TextEditingController _idController = TextEditingController();
  static final TextEditingController _usernameController =
      TextEditingController();

  static final TextEditingController _totalCostController =
      TextEditingController();

  @override
  State<SaveOrderData> createState() => _SaveOrderDataState();
}

class _SaveOrderDataState extends State<SaveOrderData> {
  final List<String> customers = [];
  final List<String> products = [];

  List<String> get fetchAllCustomers {
    for (var i = 0; i < userBox!.values.length; i++) {
      customers.add(userBox!.getAt(i)!.username!);
    }
    return customers;
  }

  List<String> get fetchAllProducts {
    for (var i = 0; i < productBox!.values.length; i++) {
      products.add(productBox!.getAt(i)!.name!);
    }
    return products;
  }
  // List<DropdownMenuItem<String>> get items {
  //   List<DropdownMenuItem<String>> items = [];
  //   for (var element in customers) {
  //     items.add(
  //       DropdownMenuItem(
  //         value: element,
  //         child: Text(element),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  @override
  void initState() {
    fetchAllCustomers;
    fetchAllProducts;
    super.initState();
  }

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

          // ID textfield.....
          const Text(
            "PRODUCT",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Autocomplete(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return products.where(
                (String option) {
                  return option.startsWith(textEditingValue.text.toLowerCase());
                },
              );
            },
          ),
          // CustomTextField(
          //   isDense: true,
          //   contentPadding: 10,
          //   color: kCardTextColor,
          //   inputType: TextInputType.text,
          //   controller: SaveOrderData._totalCostController,
          //   borderStyle: const UnderlineInputBorder(
          //     borderSide: BorderSide(
          //       color: Colors.white,
          //       width: 3,
          //     ),
          //   ),
          //   onChanged: (s) {},
          // ),
          const SizedBox(height: 35),

          // username textfield....
          const Text(
            "USERNAME",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          Autocomplete(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return customers.where(
                (String option) {
                  return option.startsWith(textEditingValue.text.toLowerCase());
                },
              );
            },
          ),
          // DropdownButton(items: items, onChanged: (s) {}, menuMaxHeight: 300),
          // CustomTextField(
          //   isDense: true,
          //   contentPadding: 10,
          //   color: kCardTextColor,
          //   inputType: TextInputType.number,
          //   controller: SaveOrderData._totalCostController,
          //   borderStyle: const UnderlineInputBorder(
          //     borderSide: BorderSide(
          //       color: Colors.white,
          //       width: 3,
          //     ),
          //   ),
          //   onChanged: (s) {},
          // ),
          // const SizedBox(height: 35),
          // const Text(
          //   "TOTAL COST",
          //   style: TextStyle(
          //     fontSize: 15,
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // CustomTextField(
          //   isDense: true,
          //   contentPadding: 10,
          //   color: kCardTextColor,
          //   inputType: TextInputType.number,
          //   controller: SaveOrderData._totalCostController,
          //   borderStyle: const UnderlineInputBorder(
          //     borderSide: BorderSide(
          //       color: Colors.white,
          //       width: 3,
          //     ),
          //   ),
          //   onChanged: (s) {},
          // ),
          // const SizedBox(height: 35),
          Center(
            child: CustomOutlinedButton(
              text: "ADD ORDER",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
