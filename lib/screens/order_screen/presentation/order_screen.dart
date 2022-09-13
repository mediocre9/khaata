import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
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

class OrderInterfaceStateManager extends StatelessWidget
    implements InterfaceStateManager {
  const OrderInterfaceStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderHomeInitial) {
          return EmptyRecordsWidget(
            message: state.message,
            icon: state.iconData,
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
              itemCount: state.orderModel.length,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) {
                var order = state.orderModel;
                return OrderCard(
                  product: order[index].productname!,
                  cost: order[index].cost.toString(),
                  username: order[index].username!,
                  completedDate: order[index].completedDate.toString(),
                  createdDate: order[index].createdDate.toString(),
                  status: order[index].status!,
                  index: index,
                );
              },
            ),
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
                completedDate: state.orderModel[index].completedDate.toString(),
                createdDate: state.orderModel[index].createdDate.toString(),
                status: state.orderModel[index].status!,
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
              ),
              Text(
                BlocProvider.of<OrderCubit>(context).totalPendingOrders.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
              ),
              Text(
                "ORDERS",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: const Color.fromRGBO(58, 52, 98, 1)),
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
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: const Color.fromRGBO(215, 215, 255, 1)),
                ),
                Text(
                  "${BlocProvider.of<OrderCubit>(context).totalGain.toString()} PKR",
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
  final String product, cost, username;
  final int index;
  final bool status;
  final String createdDate, completedDate;

  const OrderCard({
    Key? key,
    required this.product,
    required this.cost,
    required this.username,
    required this.createdDate,
    required this.index,
    required this.completedDate,
    required this.status,
  }) : super(key: key);

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
              Text(
                "RS. $cost",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
              ),
              if (status) ...[
                OrderStatusIcon(
                  data: username,
                  icon: CupertinoIcons.exclamationmark_circle,
                  color: Colors.yellow,
                ),
              ] else ...[
                OrderStatusIcon(
                  data: username,
                  icon: Icons.check_circle_rounded,
                  color: Colors.lightGreenAccent,
                ),
              ],
            ],
          ),
          enabled: true,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => OrderDetailCubit(),
                  child: OrderDetailScreen(
                    username: username,
                    product: product,
                    cost: cost,
                    createdDate: createdDate.toString(),
                    completedDate: createdDate.toString(),
                    index: index,
                  ),
                ),
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
          data,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
        ),
        Icon(icon, color: color),
      ],
    );
  }
}
