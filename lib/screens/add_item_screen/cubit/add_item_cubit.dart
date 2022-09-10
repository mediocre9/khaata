import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  addItem(String product, String stock, String cost) {
    bool isProductFound = _checkProductInInventory(product);

    if (product.isNotEmpty && stock.isNotEmpty && cost.isNotEmpty) {
      if (isProductFound) {
        emit(ItemAlreadyExist(
            "Item already is in the inventory!", Colors.redAccent));
      } else {
        productBox!.add(
          ProductModel(
            name: product,
            initialStock: int.parse(stock),
            cost: int.parse(cost),
          ),
        );
        emit(ItemAddedState("Item added successfully!", Colors.green));
      }
    } else {
      emit(ItemNotAddedState(
          "Please fill out all the given fields!", Colors.redAccent));
    }
  }

  bool _checkProductInInventory(String product) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (product.toLowerCase() == productBox!.getAt(i)!.name!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
