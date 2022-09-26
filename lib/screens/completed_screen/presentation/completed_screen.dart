import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/screens/completed_screen/cubit/completed_cubit.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/tray_container.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: Text("COMPLETED"),
        subtitle: Text("ORDERS"),
      ),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
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
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(58, 52, 98, 1),
                        ),
                      ),
                    ],
                  ),
                  const TotalCompletedGain(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const TrayContainer(
              stateManager: CompletedOrderInterfaceStateManager(),
            )
          ],
        ),
      ),
    );
  }
}

class CompletedOrderInterfaceStateManager extends StatelessWidget
    implements InterfaceStateManager {
  const CompletedOrderInterfaceStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCubit, CompletedState>(
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
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              shrinkWrap: true,
              itemCount: state.orders.length,
              itemBuilder: (_, index) {
                return CompletedOrderCard(
                  username: state.orders[index].customerName!,
                  product: state.orders[index].productName!,
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
        height: 100,
        shadow: false,
        borderRadius: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              BlocProvider.of<CompletedCubit>(context)
                  .totalCompletedOrders
                  .toString(),
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "ORDERS",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
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
            color: const Color.fromRGBO(22, 60, 98, 1),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TOTAL GAIN",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(215, 215, 255, 1),
                  ),
                ),
                Text(
                  "${BlocProvider.of<CompletedCubit>(context).completedGainMoney.toString()} PKR",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedOrderCard extends StatelessWidget with GradientDecoration {
  final String product, cost, username;

  const CompletedOrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: gradientDecoration(),
        child: ListTile(
          title: Text(
            product.trim().toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RS. $cost",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username.trim().toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
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
