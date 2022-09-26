import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  bool _checkProductInInventory(String product) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (product.trim().toLowerCase() ==
          productBox!.getAt(i)!.name!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  void addItem(String product, String stock, String cost) {
    bool isProductFound = _checkProductInInventory(product);

    if (product.isNotEmpty && stock.isNotEmpty && cost.isNotEmpty) {
      if (isProductFound) {
        emit(
          ItemAlreadyExist(
            "Item already is in the inventory!",
            Colors.redAccent,
          ),
        );
      } else {
        productBox!.add(
          Product(
            name: product.trim(),
            stock: int.parse(stock.trim()),
            cost: int.parse(cost.trim()),
          ),
        );
        emit(
          ItemAddedState(
            "Item added successfully!",
            Colors.green,
          ),
        );
      }
    } else {
      emit(
        ItemNotAddedState(
          "Please fill out all the given fields!",
          Colors.redAccent,
        ),
      );
    }
  }


}
