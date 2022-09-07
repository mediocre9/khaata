import 'package:khata/models/model/product_model.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';

part 'inventory_home_state.dart';

class InventoryHomeCubit extends Cubit<InventoryHomeState> {
  final List<ProductModel> _products = [];
  List<ProductModel> _searchedProducts = [];
  InventoryHomeCubit() : super(InventoryInititalState(message: "EMPTY LIST")) {
    _searchedProducts = _products;
    _loadInventory();
  }

  getStockStatus(int index) {
    bool isProductInStock = _searchedProducts[index].initialStock! > 0;

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
