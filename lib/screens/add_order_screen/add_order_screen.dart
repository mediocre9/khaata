import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  // final List<String> customers = [];
  // final List<String> products = [];
  // final List<int> cost = [];
  // int? itemCost = 0;
  // int? cindex = 0, pindex;

  // int? emptyStockIndex;
  // bool? isStockEmpty = false;

  // void fetchAll() {
  //   for (var i = 0; i < userBox!.values.length; i++) {
  //     customers.add(userBox!.getAt(i)!.username!.toUpperCase());
  //   }

  //   for (var i = 0; i < productBox!.values.length; i++) {
  //     products.add(productBox!.getAt(i)!.name!.toUpperCase());
  //     cost.add(productBox!.getAt(i)!.cost!);
  //   }
  // }

  // @override
  // void initState() {
  //   fetchAll();
  //   super.initState();
  // }

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
        height: 350,
        verticalMargin: 10,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(height: 25),

                  // ID textfield.....
                  Text(
                    "PRODUCT",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if (products.isNotEmpty)
                  //   DropdownButtonFormField(
                  //     hint: const Text("select product",
                  //         style: TextStyle(color: Colors.white)),
                  //     items: products
                  //         .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e),
                  //             ))
                  //         .toList(),
                  //     iconEnabledColor: Colors.white,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         pindex = products.indexOf(value!);

                  //         if (productBox!.getAt(pindex!)!.initialStock! == 0) {
                  //           emptyStockIndex = pindex;
                  //           isStockEmpty = true;
                  //         }

                  //         itemCost = cost[pindex!];
                  //       });
                  //     },
                  //     isExpanded: true,
                  //   )
                  // else
                  //   DropdownButtonFormField(items: null, onChanged: null),
                  // const SizedBox(height: 25),

                  // // username textfield....
                  // const Text(
                  //   "USERNAME",
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // if (customers.isNotEmpty)
                  //   DropdownButtonFormField(
                  //     hint: const Text("select customer",
                  //         style: TextStyle(color: Colors.white)),
                  //     items: customers
                  //         .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e),
                  //             ))
                  //         .toList(),
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         cindex = customers.indexOf(value!);
                  //       });
                  //     },
                  //     isExpanded: true,
                  //     iconEnabledColor: Colors.white,
                  //   )
                  // else
                  //   DropdownButtonFormField(onChanged: null, items: null),

                  SizedBox(height: 25),

                  Text(
                    "PRODUCT COST : ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),
                  // Center(
                  //   child: (products.isNotEmpty && customers.isNotEmpty)
                  //       ? CustomOutlinedButton(
                  //           text: "ADD ORDER",
                  //           textColor: Colors.white,
                  //           onPressed: () {
                  //             if (isStockEmpty == false) {
                  //               DateTime now = DateTime.now();

                  //               orderBox!.add(
                  //                 OrderModel(
                  //                   customers[cindex!],
                  //                   products[pindex!],
                  //                   cost[pindex!],
                  //                   DateTime(now.year, now.month, now.day),
                  //                   DateTime(now.year, now.month, now.day),
                  //                   false,
                  //                 ),
                  //               );

                  //               Navigator.pushAndRemoveUntil(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         const ManageOrderScreen(),
                  //                   ),
                  //                   (route) => false);
                  //             } else {
                  //               setState(() {});
                  //               showDialog(
                  //                 context: context,
                  //                 builder: (context) => AlertDialog(
                  //                   title: const Text("Alert"),
                  //                   content: Text(
                  //                       "Product ${productBox!.getAt(pindex!)!.name!.toLowerCase()} is out of stock."),
                  //                   actions: [
                  //                     TextButton(
                  //                         onPressed: () =>
                  //                             Navigator.pop(context),
                  //                         child: const Text("Ok"))
                  //                   ],
                  //                 ),
                  //               );
                  //             }
                  //           },
                  //         )
                  //       : CustomOutlinedButton(
                  //           onPressed: () {}, text: "ADD ORDER"),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
