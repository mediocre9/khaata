import 'package:khata/models/model/order.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/screens/customer_screen/cubit/customer_cubit_exports.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  Order? _order;
  Product? _productObject;
  int _productInitialStock = 0;
  int _productIndexInDatabase = 0;
  int _orderIndexInDatabase = 0;

  OrderDetailCubit() : super(OrderDetailInitialState());

  void init(Order order, int index) {
    _order = order;
    _orderIndexInDatabase = index;
    if (_order!.pendingStatus!) {
      emit(UnMarkedOrderState());
    } else {
      emit(MarkOrderState());
    }
  }

  void completeOrder() async {
    await orderBox!.putAt(
      _orderIndexInDatabase,
      Order(
        _order!.customerName,
        _order!.productName,
        _order!.cost,
        _order!.createdDate,
        DateTime.now(),
        false,
      ),
    );

    _productObject = _getProductObjectFromDatabase(_order!.productName!);
    if (_productObject != null) {
      _productInitialStock = _productObject!.stock! - 1;
    }

    var updatedItem = Product(
      name: _order!.productName,
      cost: _order!.cost,
      stock: _productInitialStock,
    );

    productBox!.putAt(_productIndexInDatabase, updatedItem);
  }

  Future<void> deleteOrder(int index) async {
    await orderBox!.deleteAt(index);
  }

  Product? _getProductObjectFromDatabase(String productName) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productName.trim().toLowerCase() ==
          productBox!.getAt(i)!.name!.trim().toLowerCase()) {
        _productIndexInDatabase = i;
        return productBox!.getAt(i)!;
      }
    }
    return null;
  }
}
