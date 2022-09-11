import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/models/model/user_model.dart';


part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  List<ProductModel> products = [];
  List<UserModel> customers = [];
  ProductModel? _productObject;
  int _productIndexInDatabase = 0;
  // int _productInitialStock = 0;

  AddOrderCubit() : super(AddOrderInitial()) {
    _loadData();
  }

  // initializing data.....
  void _loadData() {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productBox!.getAt(i)!.initialStock != 0) {
        products.add(productBox!.getAt(i)!);
      }
    }

    for (int i = 0; i < userBox!.values.length; i++) {
      customers.add(userBox!.getAt(i)!);
    }
  }

  // search product.....
  List<ProductModel> searchProduct(String search) {
    if (search.isNotEmpty) {
      List<ProductModel> productList = products
          .where((product) =>
              product.name!.toLowerCase().startsWith(search.toLowerCase()))
          .toList();

      if (productList.isNotEmpty) {
        emit(ProductSearchState(productList));
        return productList;
      }
    }
    return List.empty();
  }

  // search customer....
  List<UserModel> searchCustomer(String search) {
    if (search.isNotEmpty) {
      List<UserModel> customerList = customers
          .where((customer) =>
              customer.username!.toLowerCase().startsWith(search.toLowerCase()))
          .toList();

      if (customerList.isNotEmpty) {
        emit(CustomerSearchState(customerList));
        return customerList;
      }
    }
    return List.empty();
  }

  // get product object.....
  ProductModel? _getProductObject(String name) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productBox!.getAt(i)!.name!.toLowerCase() == name.toLowerCase()) {
        _productIndexInDatabase = i;
        return productBox!.getAt(i)!;
      }
    }
    return null;
  }

  // void _decreaseStockInInventory() {
  //   _productInitialStock = _productObject!.initialStock! - 1;
  // }

  void addOrder(String product, String customer) {
    if (product.isNotEmpty && customer.isNotEmpty) {
      _productObject = _getProductObject(product);

      if (_productObject != null) {
        // _decreaseStockInInventory();

        // update....
        productBox!.putAt(
          _productIndexInDatabase,
          ProductModel(
            name: _productObject!.name,
            initialStock: _productObject!.initialStock,
            cost: _productObject!.cost,
          ),
        );

        // add new order...
        orderBox!.add(
          OrderModel(
            customer,
            product,
            _productObject!.cost,
            DateTime.now(),
            DateTime.now(),
            true,
          ),
        );
      }
    }
  }
}
