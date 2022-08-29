import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  addItem(String product, String stock, String cost) {
    if (product.isNotEmpty && stock.isNotEmpty && cost.isNotEmpty) {
      productBox!.add(
        ProductModel(
          name: product,
          initialStock: int.parse(stock),
          cost: int.parse(cost),
        ),
      );
      emit(ItemAddedState("Item added successfully!", Colors.green));
    } else {
      emit(ItemNotAddedState(
          "Please fill out all the given fields!", Colors.redAccent));
    }
  }
}
