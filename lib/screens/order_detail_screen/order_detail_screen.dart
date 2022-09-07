import 'package:khata/screens/order_detail_screen/cubit/order_detail_cubit.dart';
import 'package:khata/screens/order_screen/cubit/order_home_cubit.dart';
import 'package:khata/screens/order_screen/order_screen.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class OrderDetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    BlocProvider.of<OrderDetailCubit>(context).checkOrderState(index!);
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
              height: 330,
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
                            product!.toUpperCase(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 218, 224, 236),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "RS. ${cost!.replaceAll("PKR", "")}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            username!.toUpperCase(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 218, 224, 236),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OrderStatusWidget(index: index!),
                    const SizedBox(height: 5),
                    Text(
                      "CREATED DATE : ${createdDate!.replaceRange(10, null, "")}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "COMPLETED DATE : ${completedDate!.replaceRange(10, null, "")}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 218, 224, 236),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<OrderDetailCubit, OrderDetailState>(
                              builder: (context, state) {
                            if (state is UnMarkedOrderState) {
                              return CustomOutlinedButton(
                                textColor:
                                    const Color.fromARGB(255, 218, 224, 236),
                                text: "MARK COMPLETED",
                                onPressed: () {
                                  BlocProvider.of<OrderDetailCubit>(context)
                                      .markOrderStateToComplete(
                                    index!,
                                    username!,
                                    product!,
                                    int.parse(cost!),
                                    DateTime.parse(createdDate!),
                                    DateTime.parse(completedDate!),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),
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
                                          orderBox!.deleteAt(index!);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => BlocProvider(
                                                    create: (context) =>
                                                        OrderHomeCubit(),
                                                    child:
                                                        const ManageOrderScreen()),
                                              ));
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

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var isOrderPending =
        BlocProvider.of<OrderDetailCubit>(context).getOrderStatus(index);
    String message = isOrderPending ? "PENDING" : "COMPLETED";

    return Text(
      "STATUS : $message",
      style: const TextStyle(
          color: Color.fromARGB(255, 218, 224, 236),
          fontSize: 12,
          fontWeight: FontWeight.w500),
    );
  }
}
