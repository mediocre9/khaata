import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';

import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';

class OrderPendingScreen extends StatefulWidget {
  const OrderPendingScreen({Key? key}) : super(key: key);

  @override
  State<OrderPendingScreen> createState() => _OrderPendingScreenState();
}

class _OrderPendingScreenState extends State<OrderPendingScreen> {
  static List<OrderModel?> pendingOrderList = [];

  int pendingOrders = 0;
  int totalPendingGain = 0;

  _OrderPendingScreenState();

  fetchAllData() {
    pendingOrderList.clear();
    for (var i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status! == false) {
        pendingOrderList.add(orderBox!.getAt(i));
        pendingOrders = pendingOrders + 1;
        totalPendingGain = totalPendingGain + orderBox!.getAt(i)!.cost!;
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
            title: "PENDING", titleFontSize: 23, subTitle: "ORDERS"),
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
                          TotalPendingOrder(totalPendingOrder: pendingOrders),
                          const Text(
                            "PENDING",
                            style: TextStyle(
                              color: Color.fromRGBO(58, 52, 98, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TotalPendingGain(
                            totalPendingGain: totalPendingGain,
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
                    child: pendingOrderList.isEmpty
                        ? const EmptyRecords()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: pendingOrderList.length,
                            itemBuilder: (_, index) {
                              return PendingOrderCard(
                                product: pendingOrderList[index]!
                                    .productname!
                                    .toUpperCase(),
                                cost:
                                    '${pendingOrderList[index]!.cost.toString()} PKR',
                                username: pendingOrderList[index]!.username,
                                index: index,
                                createdDate:
                                    pendingOrderList[index]!.createdDate,
                                completedDate:
                                    pendingOrderList[index]!.completedDate,
                              );
                            },
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

class TotalPendingOrder extends StatelessWidget {
  final int totalPendingOrder;
  const TotalPendingOrder({Key? key, required this.totalPendingOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 100,
        child: Column(
          children: [
            Text(
              totalPendingOrder.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
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

class TotalPendingGain extends StatelessWidget {
  final int totalPendingGain;
  const TotalPendingGain({Key? key, required this.totalPendingGain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        color: const Color.fromRGBO(22, 60, 98, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "TOTAL PENDING",
              style: TextStyle(
                color: Color.fromRGBO(215, 215, 255, 1),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text("${totalPendingGain.toString()} PKR",
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
            size: 55,
          ),
          Text(
            "PENDING ORDER LIST IS EMPTY!",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
        ],
      ),
    );
  }
}

// TODO: refactor later DRY PRINCIPLE VIOLATION......
class PendingOrderCard extends StatelessWidget {
  const PendingOrderCard({
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
    print(orderBox!.getAt(index!)!.status!);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: CustomCard(
        horizontalMargin: 15,
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 110,
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
                  fontSize: 17,
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
                      fontSize: 16,
                      letterSpacing: 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username!,
                        style: const TextStyle(
                          fontSize: 13,
                          letterSpacing: 1.1,
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.exclamationmark_circle,
                        color: Colors.yellow[300],
                      )
                    ],
                  ),
                ],
              ),
              enabled: true,
              // onTap: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => OrderDetailScreen(
              //         username: username,
              //         product: product,
              //         cost: cost,
              //         createdDate: createdDate!.toString(),
              //         completedDate: createdDate!.toString(),
              //         index: index,
              //         pendingOrders: pendingOrders,
              //       ),
              //     ),
              //   );
              // },
            ),
          ],
        ),
      ),
    );
  }
}
