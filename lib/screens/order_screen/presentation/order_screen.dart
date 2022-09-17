import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/screens/order_screen/cubit/order_cubit.dart';
import 'package:khata/screens/order_screen/sub_screens/order_detail_screen/cubit/order_detail_cubit.dart';
import 'package:khata/screens/order_screen/sub_screens/order_detail_screen/presentation/order_detail_screen.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/tray_container.dart';
import 'package:khata/widgets/record_not_found.dart';
import 'package:khata/widgets/sub_screen_navigator_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppBar(
          title: Text("MANAGE"),
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
              const SubScreenNavigatorWidget(
                label: "ADD ORDER",
                route: '/AddOrderScreen',
              ),
              const SearchFieldAreaWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  TotalOrders(),
                  PendingOrders(),
                ],
              ),
              const TotalGain(),
              const SizedBox(height: 10),
              const Text(
                "RECENT ORDERS",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TrayContainer(
                stateManager: OrderInterfaceStateManager(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFieldAreaWidget extends StatelessWidget {
  const SearchFieldAreaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "SEARCH ORDER",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Icon(
              Icons.search_rounded,
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          style: const TextStyle(color: kTextColor),
          decoration: const InputDecoration(hintText: "Search"),
          onChanged: (search) {
            BlocProvider.of<OrderCubit>(context).searchOrder(search);
          },
        ),
      ],
    );
  }
}

class OrderInterfaceStateManager extends StatelessWidget implements InterfaceStateManager {
  const OrderInterfaceStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderInitialState) {
          return EmptyRecordsWidget(
            message: state.message,
            icon: state.icon,
          );
        } else if (state is OrderLoadState) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.listOfOrders.length,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return OrderCard(
                  order: state.listOfOrders[index],
                  index: index,
                );
              },
            ),
          );
        } else if (state is OrderSearchState) {
          return ListView.builder(
            itemCount: state.listOfOrders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrderCard(
                order: state.listOfOrders[index],
                index: index,
              );
            },
          );
        } else if (state is OrderFoundState) {
          return RecordNotFoundWidget(
            message: state.message,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TotalOrders extends StatelessWidget {
  const TotalOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        shadow: false,
        borderRadius: 0,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TOTAL",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              BlocProvider.of<OrderCubit>(context).totalOrders.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "ORDERS",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class PendingOrders extends StatelessWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: const Color.fromRGBO(58, 52, 98, 1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PENDING",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
              ),
              Text(
                BlocProvider.of<OrderCubit>(context).totalPendingOrders.toString(),
                style: Theme.of(context).textTheme.headline5!.copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
              ),
              Text(
                "ORDERS",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalGain extends StatelessWidget {
  const TotalGain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            color: const Color.fromRGBO(22, 60, 98, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TOTAL GAIN",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color.fromRGBO(215, 215, 255, 1)),
                ),
                Text(
                  "${BlocProvider.of<OrderCubit>(context).totalGainedMoney.toString()} PKR",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderCard extends StatelessWidget with GradientDecoration {
  final int index;
  final Order order;
  const OrderCard({
    Key? key,
    required this.index,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: gradientDecoration(),
        child: ListTile(
          title: Text(
            order.productName!.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RS. ${order.cost}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
              ),
              if (order.pendingStatus!) ...[
                OrderStatusIcon(
                  data: order.customerName!,
                  icon: CupertinoIcons.exclamationmark_circle,
                  color: Colors.yellow,
                ),
              ] else ...[
                OrderStatusIcon(
                  data: order.customerName!,
                  icon: Icons.check_circle_rounded,
                  color: Colors.lightGreenAccent,
                ),
              ],
            ],
          ),
          enabled: true,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return BlocProvider(
                    create: (context) => OrderDetailCubit(),
                    child: OrderDetailScreen(
                      order: Order(
                        order.customerName,
                        order.productName,
                        order.cost,
                        order.createdDate,
                        order.completedDate,
                        order.pendingStatus,
                      ),
                      index: index,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderStatusIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String data;

  const OrderStatusIcon({
    Key? key,
    required this.color,
    required this.icon,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.trim().toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
        ),
        Icon(icon, color: color),
      ],
    );
  }
}
