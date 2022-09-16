import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/screens/inventory_screen/cubit/inventory_cubit.dart';
import 'package:khata/screens/inventory_screen/sub_screens/item_detail_screen/cubit/add_more_cubit.dart';
import 'package:khata/screens/inventory_screen/sub_screens/item_detail_screen/presentation/item_detail_screen.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/record_not_found.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/sub_screen_navigator_widget.dart';
import 'package:khata/widgets/tray_container.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppBar(
          title: Text("MANAGE"),
          subtitle: Text("INVENTORY"),
        ),
        endDrawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SubScreenNavigatorWidget(
                label: "ADD ITEM",
                route: '/AddItemScreen',
              ),
              SearchFieldAreaWidget(),
              TrayContainer(
                stateManager: ProductInterfaceStateManager(),
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
            Text("SEARCH PRODUCT", style: Theme.of(context).textTheme.labelMedium),
            const Icon(Icons.search_rounded, size: 14),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          style: const TextStyle(color: kTextColor),
          decoration: const InputDecoration(hintText: "Search"),
          onChanged: (item) {
            BlocProvider.of<InventoryCubit>(context).searchProduct(item);
          },
        ),
      ],
    );
  }
}

class ProductInterfaceStateManager extends StatelessWidget
    implements InterfaceStateManager {
  const ProductInterfaceStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        if (state is InventoryInititalState) {
          return EmptyRecordsWidget(
            icon: Icons.list,
            message: state.message,
          );
        } else if (state is LoadInventoryDataState) {
          var length = state.products.length;
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: length,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemBuilder: (_, index) {
                return ProductCardWidget(
                  product: state.products[index],
                  index: index,
                  isItemInStock:
                      BlocProvider.of<InventoryCubit>(context).getStockStatus(index),
                );
              },
            ),
          );
        } else if (state is ProductFoundState) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.products.length,
            itemBuilder: (_, index) {
              return ProductCardWidget(
                product: state.products[index],
                isItemInStock:
                    BlocProvider.of<InventoryCubit>(context).getStockStatus(index),
                index: index,
              );
            },
          );
        } else if (state is ProductNotFoundState) {
          return RecordNotFoundWidget(message: state.message);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProductCardWidget extends StatelessWidget with GradientDecoration {
  final Product product;
  final bool? isItemInStock;
  final int index;

  const ProductCardWidget({
    Key? key,
    required this.index,
    required this.product,
    this.isItemInStock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: gradientDecoration(),
        child: ListTile(
          title: Text(
            product.name!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RS. ${product.cost}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
              ),
              if (isItemInStock!) ...[
                Text(
                  "STOCK : ${product.stock}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
                )
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OUT OF STOCK",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
                    ),
                    const Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ]
            ],
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AddMoreCubit(),
                  child: ItemDetailScreen(
                    product: Product(
                      name: product.name,
                      stock: product.stock,
                      cost: product.cost,
                    ),
                    index: index,
                  ),
                ),
              ),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
