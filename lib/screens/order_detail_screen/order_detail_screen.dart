import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    Key? key,
    this.username,
    this.product,
    this.cost,
    this.index,
    this.createdDate,
    this.completedDate,
    this.status,
    this.pendingOrders,
  }) : super(key: key);
  final String? username, product, cost, createdDate, completedDate;
  final int? index, pendingOrders;
  final bool? status;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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

        // Drawer
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Center(
            child: CustomCard(
              innerMainAlignment: MainAxisAlignment.start,
              innerCrossAlignment: CrossAxisAlignment.start,
              width: double.maxFinite,
              shadow: true,
              height: 340,
              verticalMargin: 5,
              horizontalMargin: 30,
              elevationLevel: 5,
              borderRadius: 5,
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 8, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          color: Colors.white60,
                          icon: const Icon(Icons.close_outlined),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.only(bottom: 30, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 218, 224, 236),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "RS. ${widget.cost!.replaceAll("PKR", "")}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.username!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 218, 224, 236),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "STATUS : ${orderBox!.getAt(widget.index!)!.status! ? "COMPLETED" : "PENDING"}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "CREATED DATE : ${widget.createdDate!.replaceAll(" 00:00:00.000", "")}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "COMPLETED DATE : ${widget.completedDate!.replaceAll(" 00:00:00.000", "")}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderBox!.getAt(widget.index!)!.status! == false
                              ? CustomOutlinedButton(
                                  textColor:
                                      const Color.fromARGB(255, 218, 224, 236),
                                  text: "MARK COMPLETED",
                                  onPressed: () {
                                    // int? pending = widget.pendingOrders;
                                    setState(
                                      () {
                                        orderBox!.deleteAt(widget.index!);
                                        orderBox!.add(
                                          OrderModel(
                                            widget.username,
                                            widget.product,
                                            int.parse(widget.cost!
                                                .replaceAll(" PKR", "")),
                                            DateTime.parse(widget.createdDate!),
                                            DateTime.parse(
                                                DateTime.now().toString()),
                                            true,
                                          ),
                                        );

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ManageOrderScreen(),
                                            ),
                                            (route) => false);
                                      },
                                    );
                                  },
                                )
                              : Container(),
                          const SizedBox(height: 9),
                          CustomOutlinedButton(
                            text: "DELETE",
                            borderColor: Colors.redAccent,
                            textColor: Colors.redAccent,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Warning!"),
                                    content: const Text(
                                        "Do you really want to delete this record?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          orderBox!.deleteAt(widget.index!);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManageOrderScreen(),
                                              ),
                                              (route) => false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              key: UniqueKey(),
                                              content: const Text(
                                                  "Item deleted!",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              backgroundColor:
                                                  kSnackBarErrorColor,
                                            ),
                                          );
                                        },
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel")),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
