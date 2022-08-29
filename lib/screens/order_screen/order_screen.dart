import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';

import 'package:khata/screens/add_order_screen/add_order_screen.dart';
import 'package:khata/screens/order_detail_screen/order_detail_screen.dart';
import 'package:khata/screens/order_screen/cubit/order_home_cubit.dart';

import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);
  // static List<OrderModel?> searchList = [];
  // static List<OrderModel?> orderList = [];

  // int totalOrders = 0;
  // int pendingOrders = 0;
  // int totalGain = 0;

  // _ManageOrderScreenState();

  // fetchAllData() {
  //   orderList.clear();
  //   for (var i = 0; i < orderBox!.values.length; i++) {
  //     orderList.add(orderBox!.getAt(i));
  //     totalOrders = totalOrders + 1;

  //     // if not orders are not completed increment pending orders!
  //     if (orderBox!.getAt(i)!.status == false) {
  //       pendingOrders = pendingOrders + 1;
  //     }

  //     // if  orders are  completed increment total gain!
  //     if (orderBox!.getAt(i)!.status == true) {
  //       totalGain = totalGain + orderBox!.getAt(i)!.cost!;
  //     }
  //   }
  //   searchList = orderList;
  // }

  // @override
  // void initState() {
  //   fetchAllData();
  //   super.initState();
  // }

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
                        onChanged: (search) {
                          BlocProvider.of<OrderHomeCubit>(context)
                              .searchOrder(search);
                        },
                        controller: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          TotalOrders(totalOrders: 0),
                          PendingOrders(pendingOrders: 0),
                        ],
                      ),
                      Row(
                        children: const [
                          TotalGain(
                            totalGain: 0,
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
                    child: BlocBuilder<OrderHomeCubit, OrderHomeState>(
                      builder: (context, state) {
                        if (state is OrderHomeInitial) {
                          return EmptyRecords(
                            message: state.message,
                            iconData: state.iconData,
                          );
                        } else if (state is OrderLoadState) {
                          return ListView.builder(
                            itemCount: state.orderModel.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return OrderCard(
                                product: state.orderModel[index].productname!,
                                cost: state.orderModel[index].cost.toString(),
                                username: state.orderModel[index].username!,
                                completedDate: state
                                    .orderModel[index].completedDate
                                    .toString(),
                                createdDate: state.orderModel[index].createdDate
                                    .toString(),
                                index: index,
                              );
                            },
                          );
                        } else if (state is OrderSearchState) {
                          return ListView.builder(
                            itemCount: state.orderModel.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return OrderCard(
                                product: state.orderModel[index].productname!,
                                cost: state.orderModel[index].cost.toString(),
                                username: state.orderModel[index].username!,
                                completedDate: state
                                    .orderModel[index].completedDate
                                    .toString(),
                                createdDate: state.orderModel[index].createdDate
                                    .toString(),
                                index: index,
                              );
                            },
                          );
                        } else if (state is OrderFoundState) {
                          return OrderNotFound(
                            message: state.message,
                            iconData: state.iconData,
                          );
                        }
                        return Container();
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
              BlocProvider.of<OrderHomeCubit>(context).totalOrders.toString(),
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
            Text(
                "${BlocProvider.of<OrderHomeCubit>(context).totalGain.toString()} PKR",
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
                BlocProvider.of<OrderHomeCubit>(context)
                    .totalPendingOrders
                    .toString(),
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
  final String message;
  final IconData iconData;

  const EmptyRecords({
    Key? key,
    required this.message,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class OrderNotFound extends StatelessWidget {
  final String message;
  final IconData iconData;

  const OrderNotFound({
    Key? key,
    required this.message,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
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
    required this.createdDate,
    required this.index,
    required this.completedDate,
  }) : super(key: key);
  final String product, cost, username;
  final int index;
  final String createdDate, completedDate;
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
                product,
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
                    cost,
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
                        username,
                        style: const TextStyle(
                          fontSize: 10.5,
                          letterSpacing: 1,
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // BlocProvider.of<OrderHomeCubit>(context)
                      //             .orderListObject[index]
                      //             .status ==
                      //         false
                      //     ? const OrderStatusIcon(
                      //         iconData: Icons.check_circle_outline,
                      //         color: Colors.lightGreenAccent)
                      //     : const OrderStatusIcon(
                      //         iconData: Icons.warning, color: Colors.redAccent)
                      // BlocBuilder<OrderHomeCubit, OrderHomeState>(
                      //   builder: (context, state) {
                      //     if (state is OrderCompletedState) {
                      //       return const OrderStatusIcon(
                      //           iconData: Icons.check_circle_outline,
                      //           color: Colors.lightGreenAccent);
                      //     } else if (state is OrderNotCompletedState) {
                      //       return const OrderStatusIcon(
                      //           iconData: Icons.warning,
                      //           color: Colors.redAccent);
                      //     }
                      //     return Container();
                      //   },
                      // ),
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
                      createdDate: createdDate.toString(),
                      completedDate: createdDate.toString(),
                      index: index,
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

class OrderStatusIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  const OrderStatusIcon({
    Key? key,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: color,
    );
  }
}
