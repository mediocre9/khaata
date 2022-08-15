import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/screens/item_detail_screen/item_detail_screen.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  static List<ProductModel?> searchList = [];
  static List<ProductModel?> orderList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            title: "Manage", titleFontSize: 23, subTitle: "ORDERS"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddUserButtonPane(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "SEARCH ORDER",
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
                        hintText: "Search",
                        borderRadius: 4,
                        isDense: true,
                        contentPadding: 8,
                        onChanged: (searchOrder) {},
                        controller: null,
                      ),
                      Row(
                        children: const [
                          TotalOrders(),
                          PendingOrders(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromARGB(255, 253, 253, 253),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 0.4,
                          blurRadius: 1,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 65, 65, 65),
                          spreadRadius: 1.5,
                          blurRadius: 4,
                          offset: Offset(1, 4),
                          inset: true,
                        )
                      ],
                    ),
                    child: orderList.isEmpty
                        ? const EmptyRecords()
                        : searchList.isEmpty
                            ? const ItemNotFound()
                            : ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                }),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  shrinkWrap: true,
                                  itemCount: searchList.length,
                                  itemBuilder: (_, index) {
                                    return Container();
                                    // return OrderCard(
                                    //   itemName: searchList[index]!
                                    //       .name!
                                    //       .toUpperCase(),
                                    //   cost:
                                    //       '${searchList[index]!.cost.toString()} PKR',
                                    //   stock:
                                    //       "ITEMS IN STOCK : ${searchList[index]!.initialStock}",
                                    //   index: index,
                                    // );
                                  },
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TotalOrders extends StatelessWidget {
  const TotalOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 130,
        child: Column(
          children: const [
            Text(
              "TOTAL",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "17",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "ORDERS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingOrders extends StatelessWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple, width: 3),
          ),
          height: 115,
          child: Column(
            children: const [
              Text(
                "PEDNING",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "4",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "ORDERS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyRecords extends StatelessWidget {
  const EmptyRecords({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.list,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            "RECORD LIST IS EMPTY!",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class ItemNotFound extends StatelessWidget {
  const ItemNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search_off_rounded,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            "ORDER NOT FOUND!",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      ),
    );
  }
}

// user navigator button....
class AddUserButtonPane extends StatelessWidget {
  const AddUserButtonPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddOrderScreen(),
              ),
            );
          },
          label:
              const Text("CREATE ORDER", style: TextStyle(color: kTextColor)),
          icon: const Icon(Icons.add, color: kTextColor),
        )
      ],
    );
  }
}

// TODO: refactor later DRY PRINCIPLE VIOLATION......
class OrderCard extends StatelessWidget {
  const OrderCard(
      {Key? key,
      required this.itemName,
      required this.cost,
      required this.stock,
      this.index})
      : super(key: key);
  final String? itemName, cost, stock;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: CustomCard(
        horizontalMargin: 15,
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                itemName!,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.3,
                  color: Color.fromARGB(255, 248, 248, 248),
                  fontWeight: FontWeight.bold,
                ),
              ),
              dense: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    cost!,
                    style: const TextStyle(
                      fontSize: 17.5,
                      letterSpacing: 1,
                      color: Color.fromARGB(255, 218, 224, 236),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    stock!,
                    style: const TextStyle(
                      fontSize: 10.5,
                      letterSpacing: 1,
                      color: Color.fromARGB(255, 218, 224, 236),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              enabled: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailScreen(
                        itemName: itemName,
                        cost: cost,
                        stock: stock,
                        index: index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
