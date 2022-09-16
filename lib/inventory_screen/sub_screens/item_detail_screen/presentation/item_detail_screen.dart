import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/screens/inventory_screen/sub_screens/item_detail_screen/cubit/add_more_cubit.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class ItemDetailScreen extends StatelessWidget {
  final int index;
  final Product product;

  const ItemDetailScreen({
    Key? key,
    this.index = 0,
    required this.product,
  }) : super(key: key);

  static final TextEditingController _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawerEnableOpenDragGesture: true,
      appBar: const CustomAppBar(title: Text("Order"), subtitle: Text("Book")),

      // Drawer
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: CustomCard(
          innerMainAlignment: MainAxisAlignment.start,
          innerCrossAlignment: CrossAxisAlignment.start,
          width: double.maxFinite,
          shadow: true,
          height: 300,
          verticalMargin: 5,
          horizontalMargin: 30,
          elevationLevel: 5,
          borderRadius: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    color: Colors.white60,
                    icon: const Icon(Icons.close_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, '/InventoryScreen');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name!,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("RS. ${product.cost}",
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 5),
                    Text("STOCK: ${product.stock}",
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 25),
                    OutlinedButton(
                      child: const Text("ADD MORE"),
                      onPressed: () async {
                        await addMoreDialogBox(context);
                      },
                    ),
                    const SizedBox(height: 7),
                    CustomOutlinedButton(
                      text: "DELETE",
                      onPressed: () async {
                        await deleteItemDialogBox(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteItemDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Warning!",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
          content: Text(
            "Do you really want to delete this record?",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
          ),
          actions: [
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                productBox!.deleteAt(index);
                Navigator.pushReplacementNamed(context, '/InventoryScreen');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    key: UniqueKey(),
                    backgroundColor: kSnackBarErrorColor,
                    content: const Text(
                      "Item deleted!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> addMoreDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            "Add Stock",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
          content: TextField(
            style: const TextStyle(color: kTextColor),
            decoration: const InputDecoration(hintText: "0"),
            keyboardType: TextInputType.number,
            controller: _stockController,
            autofocus: true,
            maxLength: 5,
          ),
          actions: [
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                BlocProvider.of<AddMoreCubit>(context).addMore(
                  _stockController.text,
                  product.name!,
                );
                Navigator.pushReplacementNamed(context, '/InventoryScreen');
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
