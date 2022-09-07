import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/models/model/product_model.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());
  ProductModel? _productObject;
  int _productInitialStock = 0;
int _productIndexInDatabase = 0;
  getOrderStatus(index) => orderBox!.getAt(index)!.status == true;

  markOrderStateToComplete(int index, String username, String product, int cost,
      DateTime createdDate, DateTime completedDate) {
    orderBox!.putAt(
      index,
      OrderModel(
        username,
        product,
        cost,
        createdDate,
        DateTime.now(),
        false,
      ),
    );

    _productObject = _getProductObject(product);

    if (_productObject != null) {
      _productInitialStock = _productObject!.initialStock! - 1;
    }

    var updatedItem = ProductModel(
        name: product.toUpperCase(), cost: cost, initialStock: _productInitialStock);

    List<ProductModel> updateItemList = [];
    for (int i = 0; i < productBox!.values.length; i++) {
      updateItemList.add(productBox!.getAt(i)!);

      if (productBox!.getAt(i)!.name!.toLowerCase() == product.toLowerCase()) {
        productBox!.putAt(_productIndexInDatabase, updatedItem);
        break;
      }
    }

    emit(MarkOrderState());
  }

  ProductModel? _getProductObject(String name) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productBox!.getAt(i)!.name!.toLowerCase() == name.toLowerCase()) {
      _productIndexInDatabase = i;
        return productBox!.getAt(i)!;
      }
    }
    return null;
  }

  checkOrderState(int index) {
    if (getOrderStatus(index)) {
      emit(UnMarkedOrderState());
    } else {
      emit(MarkOrderState());
    }
  }
}
