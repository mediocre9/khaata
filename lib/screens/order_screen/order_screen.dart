import 'dart:ui';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';

import 'package:khata/screens/add_order_screen/add_order_screen.dart';
import 'package:khata/screens/order_detail_screen/order_detail_screen.dart';

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
  static List<OrderModel?> searchList = [];
  static List<OrderModel?> orderList = [];

  int totalOrders = 0;
  int pendingOrders = 0;
  int totalGain = 0;

  _ManageOrderScreenState();

  fetchAllData() {
    orderList.clear();
    for (var i = 0; i < orderBox!.values.length; i++) {
      orderList.add(orderBox!.getAt(i));
      totalOrders = totalOrders + 1;

      // if not orders are not completed increment pending orders!
      if (orderBox!.getAt(i)!.status == false) {
        pendingOrders = pendingOrders + 1;
      }

      // if  orders are  completed increment total gain!
      if (orderBox!.getAt(i)!.status == true) {
        totalGain = totalGain + orderBox!.getAt(i)!.cost!;
      }
    }
    searchList = orderList;
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

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
                        onChanged: (searchOrder) {
                          searchList = orderList
                              .where((user) => user!.username!
                                  .toLowerCase()
                                  .startsWith(searchOrder.toLowerCase()))
                              .toList();
                          setState(() {});
                        },
                        controller: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TotalOrders(totalOrders: totalOrders),
                          PendingOrders(pendingOrders: pendingOrders),
                        ],
                      ),
                      Row(
                        children: [
                          TotalGain(
                            totalGain: totalGain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text(
                            "RECENT ORDERS",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(top: 5),
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
                            ? const OrderNotFound()
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
                                    return OrderCard(
                                      product: searchList[index]!
                                          .productname!
                                          .toUpperCase(),
                                      cost:
                                          '${searchList[index]!.cost.toString()} PKR',
                                      username: searchList[index]!.username,
                                      index: index,
                                      createdDate:
                                          searchList[index]!.createdDate,
                                      completedDate:
                                          searchList[index]!.completedDate,
                                    );
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
  final int totalOrders;
  const TotalOrders({Key? key, required this.totalOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 110,
        child: Column(
          children: [
            const Text(
              "TOTAL",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              totalOrders.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
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

class TotalGain extends StatelessWidget {
  final int totalGain;
  const TotalGain({Key? key, required this.totalGain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color.fromRGBO(22, 60, 98, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "TOTAL GAIN",
              style: TextStyle(
                color: Color.fromRGBO(215, 215, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text("${totalGain.toString()} PKR",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}

class PendingOrders extends StatelessWidget {
  final int? pendingOrders;
  const PendingOrders({Key? key, this.pendingOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(58, 52, 98, 1), width: 3),
          ),
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "PENDING",
                style: TextStyle(
                  color: Color.fromRGBO(58, 52, 98, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                pendingOrders.toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(58, 52, 98, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "ORDERS",
                style: TextStyle(
                  color: Color.fromRGBO(58, 52, 98, 1),
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

class OrderNotFound extends StatelessWidget {
  const OrderNotFound({
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
  const OrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
    this.createdDate,
    this.index,
    this.completedDate,
    this.pendingOrders,
  }) : super(key: key);
  final String? product, cost, username;
  final int? index, pendingOrders;
  final DateTime? createdDate, completedDate;
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
                product!,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.3,
                  color: Color.fromARGB(255, 218, 224, 236),
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username!,
                        style: const TextStyle(
                          fontSize: 10.5,
                          letterSpacing: 1,
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      orderBox!.getAt(index!)!.status!
                          ? const Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.lightGreenAccent,
                            )
                          : const Text(
                              "PENDING",
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              enabled: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(
                      username: username,
                      product: product,
                      cost: cost,
                      createdDate: createdDate!.toString(),
                      completedDate: createdDate!.toString(),
                      index: index,
                      pendingOrders: pendingOrders,
                    ),
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
