import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/screens/pending_screen/cubit/pending_cubit.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/tray_container.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: Text("PENDING"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                TotalPendingOrder(),
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
            const TotalPendingGain(),
            const SizedBox(height: 10),
            const TrayContainer(
              stateManager: PendingInterfaceStateManger(),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingInterfaceStateManger extends StatelessWidget
    implements InterfaceStateManager {
  const PendingInterfaceStateManger({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingCubit, PendingState>(
      builder: (context, state) {
        if (state is PendingOrderInitial) {
          return EmptyRecordsWidget(
            message: state.message,
            icon: state.iconData,
          );
        } else if (state is PendingStateCard) {
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
              itemCount: state.orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PendingOrderCard(
                  product: state.orders[index].productName!,
                  cost: state.orders[index].cost.toString(),
                  username: state.orders[index].customerName!,
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class TotalPendingOrder extends StatelessWidget {
  const TotalPendingOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              BlocProvider.of<PendingCubit>(context).totalPendingOrders.toString(),
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
  const TotalPendingGain({Key? key}) : super(key: key);

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
                  "TOTAL PENDING",
                  style: TextStyle(
                    color: Color.fromRGBO(215, 215, 255, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${BlocProvider.of<PendingCubit>(context).pendingMoney.toString()} PKR",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
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

class PendingOrderCard extends StatelessWidget with GradientDecoration {
  final String product, cost, username;

  const PendingOrderCard({
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
              const SizedBox(height: 5),
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
                        .titleMedium!
                        .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
                  ),
                  Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: Colors.yellow[300],
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
