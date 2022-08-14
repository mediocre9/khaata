import 'dart:ui';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';

import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';

class OrderCompletedScreen extends StatefulWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  @override
  State<OrderCompletedScreen> createState() => _OrderPendingScreenState();
}

class _OrderPendingScreenState extends State<OrderCompletedScreen> {
  static List<OrderModel?> completedOrderList = [];

  int completedOrders = 0;
  int totalCompletedOrders = 0;

  _OrderPendingScreenState();

  fetchAllData() {
    completedOrderList.clear();
    for (var i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status! == true) {
        completedOrderList.add(orderBox!.getAt(i));
        completedOrders = completedOrders + 1;
        totalCompletedOrders = totalCompletedOrders + orderBox!.getAt(i)!.cost!;
      }
    }
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
            title: "COMPLETED", titleFontSize: 23, subTitle: "ORDERS"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TotalCompletedOrder(completedOrder: completedOrders),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: const Text(
                              "COMPLETED",
                              style: TextStyle(
                                color: Color.fromRGBO(58, 52, 98, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TotalCompletedGain(
                            totalCompletedOrders: totalCompletedOrders,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                    child: completedOrderList.isEmpty
                        ? const EmptyRecords()
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
                              itemCount: completedOrderList.length,
                              itemBuilder: (_, index) {
                                return CompletedOrderCard(
                                  product: completedOrderList[index]!
                                      .productname!
                                      .toUpperCase(),
                                  cost:
                                      '${completedOrderList[index]!.cost.toString()} PKR',
                                  username: completedOrderList[index]!.username,
                                  index: index,
                                  createdDate:
                                      completedOrderList[index]!.createdDate,
                                  completedDate:
                                      completedOrderList[index]!.completedDate,
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

class TotalCompletedOrder extends StatelessWidget {
  final int completedOrder;
  const TotalCompletedOrder({Key? key, required this.completedOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 110,
        child: Column(
          children: [
            Text(
              completedOrder.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
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

class TotalCompletedGain extends StatelessWidget {
  final int totalCompletedOrders;
  const TotalCompletedGain({Key? key, required this.totalCompletedOrders})
      : super(key: key);

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
              "TOTAL COMPLETED",
              style: TextStyle(
                color: Color.fromRGBO(215, 215, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text("${totalCompletedOrders.toString()} PKR",
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

// TODO: refactor later DRY PRINCIPLE VIOLATION......
class CompletedOrderCard extends StatelessWidget {
  const CompletedOrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
    this.createdDate,
    this.index,
    this.completedDate,
    this.completedOrders,
  }) : super(key: key);
  final String? product, cost, username;
  final int? index, completedOrders;
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
                      orderBox!.getAt(index!)!.status! == true
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.lightGreenAccent,
                            )
                          : Icon(
                              CupertinoIcons.exclamationmark_circle,
                              color: Colors.yellow[300],
                            )
                    ],
                  ),
                ],
              ),
              enabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
