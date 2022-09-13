import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/models/model/customer.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  List<Product> products = [];
  List<Customer> customers = [];
  Product? _productObject;
  int _productIndexInDatabase = 0;
  // int _productInitialStock = 0;

  AddOrderCubit() : super(AddOrderInitial()) {
    _loadData();
  }

  // initializing data.....
  void _loadData() {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productBox!.getAt(i)!.stock != 0) {
        products.add(productBox!.getAt(i)!);
      }
    }

    for (int i = 0; i < userBox!.values.length; i++) {
      customers.add(userBox!.getAt(i)!);
    }
  }

  // search product.....
  List<Product> searchProduct(String search) {
    if (search.isNotEmpty) {
      List<Product> productList = products
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
  List<Customer> searchCustomer(String search) {
    if (search.isNotEmpty) {
      List<Customer> customerList = customers
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
  Product? _getProductObject(String name) {
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
          Product(
            name: _productObject!.name,
            stock: _productObject!.stock,
            cost: _productObject!.cost,
          ),
        );

        // add new order...
        orderBox!.add(
          Order(
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
