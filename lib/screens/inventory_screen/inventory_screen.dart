import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/screens/add_item_screen/add_item_screen.dart';
import 'package:khata/screens/add_item_screen/bloc/add_item_bloc.dart';
import 'package:khata/screens/item_detail_screen/item_detail_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

class ManageInventoryScreen extends StatefulWidget {
  const ManageInventoryScreen({Key? key}) : super(key: key);

  @override
  State<ManageInventoryScreen> createState() => _ManageInventoryScreenState();
}

class _ManageInventoryScreenState extends State<ManageInventoryScreen> {
  static List<ProductModel?> searchList = [];
  static List<ProductModel?> productList = [];

  _ManageInventoryScreenState();
  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  fetchAllData() {
    productList.clear();
    for (var i = 0; i < productBox!.values.length; i++) {
      productList.add(productBox!.getAt(i));
    }
    searchList = productList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            title: "Manage", titleFontSize: 23, subTitle: "Inventory"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddUserButtonPane(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "SEARCH ITEM",
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                            ),
                          ),
                          Icon(Icons.search_rounded, size: 14)
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                        hintText: "Search",
                        borderRadius: 4,
                        isDense: true,
                        contentPadding: 8,
                        onChanged: (searchItem) {
                          searchList = productList
                              .where((user) => user!.name!
                                  .toLowerCase()
                                  .startsWith(searchItem.toLowerCase()))
                              .toList();
                          setState(() {});
                        },
                        controller: null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(top: 30),
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
                    child: productList.isEmpty
                        ? const EmptyRecords()
                        : searchList.isEmpty
                            ? const ItemNotFound()
                            : ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                }),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  shrinkWrap: true,
                                  itemCount: searchList.length,
                                  itemBuilder: (_, index) {
                                    return ItemCard(
                                      itemName: searchList[index]!
                                          .name!
                                          .toUpperCase(),
                                      cost:
                                          '${searchList[index]!.cost.toString()} PKR',
                                      stock: searchList[index]!.initialStock! >
                                              0
                                          ? "ITEMS IN STOCK : ${searchList[index]!.initialStock}"
                                          : "OUT OF STOCK",
                                      index: index,
                                    );
                                  },
                                ),
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

class EmptyRecords extends StatelessWidget {
  const EmptyRecords({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.list,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            "RECORD LIST IS EMPTY!",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class ItemNotFound extends StatelessWidget {
  const ItemNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search_off_rounded,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            "ITEM NOT FOUND!",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      ),
    );
  }
}

// user navigator button....
class AddUserButtonPane extends StatelessWidget {
  const AddUserButtonPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ItemBloc(),
                  child: const AddItemScreen(),
                ),
              ),
            );
          },
          label: const Text("ADD ITEM", style: TextStyle(color: kTextColor)),
          icon: const Icon(Icons.add, color: kTextColor),
        )
      ],
    );
  }
}

// TODO: refactor later DRY PRINCIPLE VIOLATION......
class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.itemName,
      required this.cost,
      required this.stock,
      this.index})
      : super(key: key);
  final String? itemName, cost, stock;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: CustomCard(
        horizontalMargin: 15,
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                itemName!,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.3,
                  color: Color.fromARGB(255, 248, 248, 248),
                  fontWeight: FontWeight.bold,
                ),
              ),
              dense: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    cost!,
                    style: const TextStyle(
                      fontSize: 17.5,
                      letterSpacing: 1,
                      color: Color.fromARGB(255, 218, 224, 236),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  stock! != "OUT OF STOCK"
                      ? Text(
                          stock!,
                          style: const TextStyle(
                            fontSize: 10.5,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 218, 224, 236),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stock!,
                              style: const TextStyle(
                                fontSize: 10.5,
                                letterSpacing: 1,
                                color: Color.fromARGB(255, 218, 224, 236),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.warning_amber_outlined,
                                color: Colors.redAccent),
                          ],
                        ),
                ],
              ),
              enabled: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailScreen(
                        itemName: itemName,
                        cost: cost,
                        stock: stock,
                        index: index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
