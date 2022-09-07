import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/screens/add_item_screen/add_item_screen.dart';
import 'package:khata/screens/add_item_screen/cubit/add_item_cubit.dart';
import 'package:khata/screens/inventory_home_screen/cubit/inventory_home_cubit.dart';
import 'package:khata/screens/item_detail_screen/cubit/add_more_cubit.dart';
import 'package:khata/screens/item_detail_screen/item_detail_screen.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';
import 'package:khata/widgets/data_not_found.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/neumorphic_tray_mixin.dart';

class InventoryHomeScreen extends StatelessWidget {
  const InventoryHomeScreen({Key? key}) : super(key: key);
  static final TextEditingController _search = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AddItemCubit(),
                              child: const AddItemScreen(),
                            ),
                          ),
                        );
                      },
                      label: const Text("ADD ITEM",
                          style: TextStyle(color: kTextColor)),
                      icon: const Icon(Icons.add, color: kTextColor),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "SEARCH PRODUCT",
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
                      onChanged: (item) {
                        BlocProvider.of<InventoryHomeCubit>(context)
                            .searchProduct(item);
                      },
                      controller: _search,
                    ),
                  ],
                ),
                const ProductListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    Key? key,
    required this.itemName,
    required this.cost,
    required this.stock,
    required this.index,
    this.isItemInStock,
  }) : super(key: key);
  final String itemName, cost, stock;
  final bool? isItemInStock;
  final int index;
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
                itemName,
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
                    "RS. $cost",
                    style: const TextStyle(
                      fontSize: 17.5,
                      letterSpacing: 1,
                      color: Color.fromARGB(255, 218, 224, 236),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  if (isItemInStock!) ...[
                    Text(
                      "STOCK : $stock",
                      style: const TextStyle(
                        fontSize: 10.5,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 218, 224, 236),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "OUT OF STOCK",
                          style: TextStyle(
                            fontSize: 10.5,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 218, 224, 236),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.warning_amber_outlined,
                            color: Colors.redAccent),
                      ],
                    ),
                  ]
                ],
              ),
              enabled: true,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AddMoreCubit(),
                        child: ItemDetailScreen(
                          itemName: itemName,
                          cost: cost,
                          stock: stock,
                          index: index,
                        ),
                      ),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListView extends StatelessWidget with NeumorphicTray{
  const ProductListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 30),
        decoration: neumorphicTrayDecoration(),
        child: BlocBuilder<InventoryHomeCubit, InventoryHomeState>(
          builder: (context, state) {
            if (state is InventoryInititalState) {
              return EmptyRecordsWidget(
                icon: Icons.list,
                message: state.message,
              );
            } else if (state is LoadInventoryDataState) {
              var product = state.products;
              var length = state.products.length;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (_, index) {
                  return ProductCardWidget(
                    itemName: product[index].name!.toUpperCase(),
                    cost: product[index].cost.toString(),
                    stock: product[index].initialStock.toString().toUpperCase(),
                    index: index,
                    isItemInStock: BlocProvider.of<InventoryHomeCubit>(context)
                        .getStockStatus(index),
                  );
                },
              );
            } else if (state is ProductFoundState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  return ProductCardWidget(
                    itemName: state.products[index].name!.toUpperCase(),
                    cost: state.products[index].cost.toString(),
                    stock: state.products[index].initialStock
                        .toString()
                        .toUpperCase(),
                    index: index,
                    isItemInStock: BlocProvider.of<InventoryHomeCubit>(context)
                        .getStockStatus(index),
                  );
                },
              );
            } else if (state is ProductNotFoundState) {
              return DataNotFoundWidget(message: state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}





