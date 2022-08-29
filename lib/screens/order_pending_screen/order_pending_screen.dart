import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:khata/screens/order_pending_screen/cubit/pending_order_cubit.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';

class OrderPendingScreen extends StatelessWidget {
  const OrderPendingScreen({Key? key}) : super(key: key);

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
                        children: const [
                          TotalPendingOrder(totalPendingOrder: "0"),
                          Text(
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
                        children: const [
                          TotalPendingGain(
                            totalPendingGain: 0,
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
                    child: BlocBuilder<PendingOrderCubit, PendingOrderState>(
                      builder: (context, state) {
                        if (state is PendingOrderInitial) {
                          return EmptyRecords(
                            message: state.message,
                            iconData: state.iconData,
                          );
                        } else if (state is PendingOrderStateCard) {
                          return ListView.builder(
                            itemCount: state.orders.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return PendingOrderCard(
                                product: state.orders[index].productname!,
                                cost: state.orders[index].cost.toString(),
                                username: state.orders[index].username!,
                              );
                            },
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

class TotalPendingOrder extends StatelessWidget {
  final String totalPendingOrder;
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
              BlocProvider.of<PendingOrderCubit>(context)
                  .totalPendingOrders
                  .toString(),
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
            Text(
                "${BlocProvider.of<PendingOrderCubit>(context).pendingMoney.toString().toString()} PKR",
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
  final String message;
  final IconData iconData;

  const EmptyRecords({Key? key, required this.message, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: Colors.grey, size: 55),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          )
        ],
      ),
    );
  }
}

class PendingOrderCard extends StatelessWidget {
  const PendingOrderCard({
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
                product,
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
                    cost,
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
                      Icon(
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
