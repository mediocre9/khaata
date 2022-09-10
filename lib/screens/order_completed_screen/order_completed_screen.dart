import 'package:flutter/gestures.dart';
import 'package:khata/screens/order_completed_screen/cubit/order_complete_cubit.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: "COMPLETED", subTitle: "ORDERS"),
      endDrawer: const CustomDrawer(),
      body: Padding(
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
                      TotalCompletedOrder(),
                      Text(
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
                  const TotalCompletedGain(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const NeumorphicContainer(cubitStateManager: CompletedOrderInterfaceStateManager())
          ],
        ),
      ),
    );
  }
}

class CompletedOrderInterfaceStateManager extends StatelessWidget {
  const CompletedOrderInterfaceStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCompleteCubit, OrderCompleteState>(
      builder: (context, state) {
        if (state is OrderCompleteInitial) {
          return EmptyRecordsWidget(
            icon: state.iconData,
            message: state.message,
          );
        } else if (state is CompletedOrdersState) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.orders.length,
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              itemBuilder: (_, index) {
                return CompletedOrderCard(
                  username: state.orders[index].username!,
                  product: state.orders[index].productname!,
                  cost: state.orders[index].cost.toString(),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TotalCompletedOrder extends StatelessWidget {
  const TotalCompletedOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              BlocProvider.of<OrderCompleteCubit>(context).totalCompletedOrders.toString(),
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
  const TotalCompletedGain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
                Text("${BlocProvider.of<OrderCompleteCubit>(context).completedGainMoney.toString()} PKR",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedOrderCard extends StatelessWidget with GradientBoxDecoration {
  const CompletedOrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
  }) : super(key: key);
  final String product, cost, username;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: gradientDecoration(),
        child: ListTile(
          title: Text(
            product.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                "RS. $cost",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color.fromARGB(255, 218, 224, 236),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 218, 224, 236),
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
        ),
      ),
    );
  }
}
