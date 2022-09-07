import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/screens/order_completed_screen/cubit/order_complete_cubit.dart';

import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/neumorphic_tray_mixin.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

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
                          TotalCompletedOrder(
                              completedOrder:
                                  BlocProvider.of<OrderCompleteCubit>(context)
                                      .totalCompletedOrders),
                          const Text(
                            "COMPLETED",
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
                          TotalCompletedGain(
                            totalCompletedOrders:
                                BlocProvider.of<OrderCompleteCubit>(context)
                                    .completedGainMoney,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const OrderCompletedListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCompletedListView extends StatelessWidget with NeumorphicTray {
  const OrderCompletedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 3),
        decoration: neumorphicTrayDecoration(),
        child: BlocBuilder<OrderCompleteCubit, OrderCompleteState>(
          builder: (context, state) {
            if (state is OrderCompleteInitial) {
              return EmptyRecordsWidget(
                icon: state.iconData,
                message: state.message,
              );
            } else if (state is CompletedOrdersState) {
              return ListView.builder(
                itemCount: state.orders.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return CompletedOrderCard(
                    username: state.orders[index].username!,
                    product: state.orders[index].productname!,
                    cost: state.orders[index].cost.toString(),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
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
        height: 100,
        child: Column(
          children: [
            Text(
              completedOrder.toString(),
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

class TotalCompletedGain extends StatelessWidget {
  final int totalCompletedOrders;
  const TotalCompletedGain({Key? key, required this.totalCompletedOrders})
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
              "TOTAL GAIN",
              style: TextStyle(
                color: Color.fromRGBO(215, 215, 255, 1),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
                "${BlocProvider.of<OrderCompleteCubit>(context).completedGainMoney.toString()} PKR",
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

class CompletedOrderCard extends StatelessWidget {
  const CompletedOrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
  }) : super(key: key);
  final String product, cost, username;
  @override
  Widget build(BuildContext context) {
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
                product.toUpperCase(),
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
                    "RS. $cost",
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
                        username,
                        style: const TextStyle(
                          fontSize: 13,
                          letterSpacing: 1.1,
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.lightGreenAccent,
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
