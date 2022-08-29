import 'package:khata/models/model/product_model.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';

part 'inventory_home_state.dart';

class InventoryHomeCubit extends Cubit<InventoryHomeState> {
  final List<ProductModel> _products = [];
  InventoryHomeCubit() : super(InventoryInititalState(message: "EMPTY LIST")) {
    _loadInventory();
  }

  stockStatus(int index) {
    if (productBox!.getAt(index)!.initialStock == 0) {
      emit(
        ProductOutOfStockState(
          "OUT OF STOCK",
          Icons.warning_amber_outlined,
          Colors.redAccent,
        ),
      );
    } else {
      emit(ProductInStockState(productBox!.getAt(index)!.initialStock.toString()));
    }
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
    List<ProductModel> searchedProducts = _products
        .where((product) =>
            product.name!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();

    if (searchedProducts.isNotEmpty) {
      emit(ProductFoundState(products: searchedProducts));
    } else {
      emit(const ProductNotFoundState(message: "PRODUCT NOT FOUND!"));
    }
  }
}
