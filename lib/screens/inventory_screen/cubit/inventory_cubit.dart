import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final List<Product> _products = [];
  List<Product> _searchedProducts = [];
  InventoryCubit() : super(InventoryInititalState(message: "EMPTY LIST")) {
    _searchedProducts = _products;
    _loadInventory();
  }

  getStockStatus(int index) {
    bool isProductInStock = _searchedProducts[index].stock! > 0;

    if (isProductInStock) {
      return true;
    }
    return false;
  }

  void _loadInventory() {
    for (int i = 0; i < productBox!.values.length; i++) {
      _products.add(productBox!.getAt(i)!);
    }

    if (_products.isNotEmpty) {
      emit(LoadInventoryDataState(products: _products));
    } else {
      emit(InventoryInititalState(message: "EMPTY LIST!"));
    }
  }

  searchProduct(String search) {
    _searchedProducts = _products
        .where((product) =>
            product.name!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();

    if (_searchedProducts.isNotEmpty) {
      emit(ProductFoundState(products: _searchedProducts));
    } else {
      emit(const ProductNotFoundState(message: "PRODUCT NOT FOUND!"));
    }
  }
}
