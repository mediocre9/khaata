import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/screens/order_screen/sub_screens/order_detail_screen/cubit/order_detail_cubit.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final int index;
  const OrderDetailScreen({
    Key? key,
    required this.order,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderDetailCubit>(context).init(order, index);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawerEnableOpenDragGesture: true,
      appBar: const CustomAppBar(
        title: Text("Order"),
        subtitle: Text("Book"),
      ),

      // Drawer
      endDrawer: const CustomDrawer(),
      body: Center(
        child: CustomCard(
          innerMainAlignment: MainAxisAlignment.start,
          innerCrossAlignment: CrossAxisAlignment.start,
          width: double.maxFinite,
          shadow: true,
          height: 350,
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
                Container(
                  padding: const EdgeInsets.only(bottom: 30, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName!.toUpperCase(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "RS. ${order.cost!}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        order.customerName!.toUpperCase(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                OrderStatusWidget(status: order.pendingStatus!),
                const SizedBox(height: 5),
                Text(
                  "CREATED DATE : ${DateUtils.dateOnly(order.createdDate!).toString().replaceRange(10, null, "")}",
                  style: const TextStyle(color: Color.fromARGB(255, 218, 224, 236), fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  "COMPLETED DATE : ${DateUtils.dateOnly(order.completedDate!).toString().replaceRange(10, null, "")}",
                  style: const TextStyle(color: Color.fromARGB(255, 218, 224, 236), fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<OrderDetailCubit, OrderDetailState>(
                        builder: (context, state) {
                          if (state is UnMarkedOrderState) {
                            return OutlinedButton(
                              child: const Text("MARK COMPLETED"),
                              onPressed: () {
                                BlocProvider.of<OrderDetailCubit>(context).completeOrder();

                                Navigator.pushReplacementNamed(context, '/OrderScreen');
                              },
                            );
                          } else {
                            return Container(height: 35);
                          }
                        },
                      ),
                      const SizedBox(height: 7),
                      CustomOutlinedButton(
                        text: "DELETE",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Warning!",
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                                ),
                                content: Text(
                                  "Do you really want to delete this record?",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      orderBox!.deleteAt(index);
                                      Navigator.pushReplacementNamed(context, '/OrderScreen');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          key: UniqueKey(),
                                          content: const Text(
                                            "Item deleted!",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          backgroundColor: kSnackBarErrorColor,
                                        ),
                                      );
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
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
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  final bool status;
  const OrderStatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = status ? "PENDING" : "COMPLETED";

    return Text(
      "STATUS : $message",
      style: const TextStyle(
        color: Color.fromARGB(255, 218, 224, 236),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
