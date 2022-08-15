import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/screens/inventory_screen/inventory_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen(
      {Key? key, this.itemName, this.cost, this.stock, this.index})
      : super(key: key);
  final String? itemName, cost, stock;
  final int? index;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final TextEditingController _stockController = TextEditingController();

  @override
  void dispose() {
    _stockController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              height: 340,
              verticalMargin: 5,
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
                    const SizedBox(height: 5),
                    Text(
                      widget.itemName!,
                      style: const TextStyle(
                        color: kCardTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      "RS. ${widget.cost!.replaceAll("PKR", "")}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.stock!,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomOutlinedButton(
                            textColor: const Color.fromARGB(255, 218, 224, 236),
                            text: "ADD MORE TO STOCK",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Add Stock"),
                                    content: TextField(
                                      controller: _stockController,
                                      keyboardType: TextInputType.number,
                                      autofocus: true,
                                      decoration:
                                          const InputDecoration(hintText: "0"),
                                      maxLength: 5,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          var object =
                                              productBox!.getAt(widget.index!);
                                          object!.initialStock = object
                                                  .initialStock! +
                                              int.parse(_stockController.text);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManageInventoryScreen(),
                                              ),
                                              (route) => false);
                                        },
                                        child: const Text("Add"),
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
                                          onPressed: () {
                                            productBox!.deleteAt(widget.index!);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ManageInventoryScreen(),
                                                ),
                                                (route) => false);
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
                                          child: const Text("Yes")),
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
