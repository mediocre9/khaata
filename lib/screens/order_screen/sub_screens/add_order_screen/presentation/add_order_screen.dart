import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/models/model/customer.dart';
import 'package:khata/screens/order_screen/sub_screens/add_order_screen/cubit/add_order_cubit.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  static final TextEditingController productController = TextEditingController();
  static final TextEditingController customerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Order"),
        subtitle: Text("Book"),
      ),
      endDrawer: const CustomDrawer(),
      endDrawerEnableOpenDragGesture: true,
      body: CustomCard(
        innerMainAlignment: MainAxisAlignment.center,
        width: double.maxFinite,
        height: 350,
        verticalMargin: 10,
        horizontalMargin: 30,
        elevationLevel: 5,
        borderRadius: 5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.white60,
                  iconSize: 22,
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/OrderScreen');
                  },
                ),
              ],
            ),
            const Text(
              "ADD ORDER",
              style: TextStyle(
                  color: kCardTextColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),

// // username textfield....
                  const Text(
                    "CUSTOMER",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  RawAutocomplete(
                    focusNode: FocusNode(),
                    key: GlobalKey(),
                    textEditingController: customerController,
                    fieldViewBuilder: (
                      context,
                      customerController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      return CustomTextField(
                        isDense: true,
                        contentPadding: 10,
                        focusNode: focusNode,
                        color: kCardTextColor,
                        inputType: TextInputType.name,
                        controller: customerController,
                        onChanged: (s) {},
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return BlocProvider.of<AddOrderCubit>(context)
                          .search<Customer>(textEditingValue.text);
                    },
                    onSelected: (Customer selection) {},
                    optionsViewBuilder:
                        (context, onSelected, Iterable<Customer> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: const Color.fromARGB(255, 233, 233, 233),
                          child: SizedBox(
                            width: 200,
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Text(
                                      options.elementAt(index).username!.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                        "Address: ${options.elementAt(index).address!.toString()}"),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),
// ID textfield.....
                  const Text(
                    "PRODUCT",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RawAutocomplete(
                    focusNode: FocusNode(),
                    key: GlobalKey(),
                    textEditingController: productController,
                    fieldViewBuilder: (
                      context,
                      productController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      return CustomTextField(
                        isDense: true,
                        contentPadding: 10,
                        focusNode: focusNode,
                        color: kCardTextColor,
                        inputType: TextInputType.name,
                        controller: productController,
                        onChanged: (s) {},
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return BlocProvider.of<AddOrderCubit>(context)
                          .search<Product>(textEditingValue.text);
                    },
                    onSelected: (Product selection) {},
                    optionsViewBuilder:
                        (context, onSelected, Iterable<Product> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: const Color.fromARGB(255, 233, 233, 233),
                          child: SizedBox(
                            width: 200,
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // onSelected(options.elementAt(index));
                                  },
                                  child: ListTile(
                                    title: Text(
                                      options.elementAt(index).name!.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "RS. ${options.elementAt(index).cost!.toString()}"),
                                        Text(
                                            "stock : ${options.elementAt(index).stock!.toString()}"),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),
                  Center(
                    child: OutlinedButton(
                      child: const Text("ADD ORDER"),
                      // textColor: Colors.white,
                      onPressed: () async {
                        await BlocProvider.of<AddOrderCubit>(context).addOrder(
                          productController.text,
                          customerController.text,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
