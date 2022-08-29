import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemName, cost, stock;
  final int index;
  const ItemDetailScreen(
      {Key? key,
      this.itemName = "nil",
      this.cost = "nil",
      this.stock = 'nil',
      this.index = 0})
      : super(key: key);

  static final TextEditingController _stockController = TextEditingController();

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
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: CustomCard(
              innerMainAlignment: MainAxisAlignment.start,
              innerCrossAlignment: CrossAxisAlignment.start,
              width: double.maxFinite,
              shadow: true,
              height: 270,
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
                    const SizedBox(height: 3),
                    Text(
                      itemName,
                      style: const TextStyle(
                        color: kCardTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "RS. ${cost.replaceAll("PKR", "")}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "ITEMS IN STOCK: $stock",
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomOutlinedButton(
                            textColor: const Color.fromARGB(255, 218, 224, 236),
                            text: "ADD MORE",
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
                                          var object = productBox!.getAt(index);
                                          object!.initialStock = object
                                                  .initialStock! +
                                              int.parse(_stockController.text);
                                          Navigator.pushReplacementNamed(
                                              context,
                                              '/manageInventoryScreen');
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
                                            productBox!.deleteAt(index);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                '/manageInventoryScreen');
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
