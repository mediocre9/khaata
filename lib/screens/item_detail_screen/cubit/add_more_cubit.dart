import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';

part 'add_more_state.dart';

class AddMoreCubit extends Cubit<AddMoreState> {
  late ProductModel? _productObject;
  int _stockValue = 0;
  int _productIndex = 0;
  AddMoreCubit() : super(AddMoreInitial());

  void addMore(String stock, String productName) {
    if (stock.isNotEmpty) {
      _productObject = _findProduct(productName);

      if (_productObject != null) {
        _increaseStock(stock);
        _updateProduct();
      }
    }
  }

  ProductModel? _findProduct(String productName) {
    int length = productBox!.values.length;
    for (int i = 0; i < length; i++) {
      if (productName.toLowerCase() ==
          productBox!.getAt(i)!.name!.toLowerCase()) {
        _productIndex = i;
        return productBox!.getAt(i);
      }
    }
    return null;
  }

  void _increaseStock(String stock) {
    _stockValue = int.parse(stock);
    _stockValue = _stockValue + _productObject!.initialStock!;
  }

  void _updateProduct() {
    productBox!.putAt(
      _productIndex,
      ProductModel(
        name: _productObject!.name,
        initialStock: _stockValue,
        cost: _productObject!.cost,
      ),
    );
  }
}
