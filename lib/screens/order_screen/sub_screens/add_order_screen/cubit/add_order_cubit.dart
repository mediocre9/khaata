import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/models/model/customer.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  final List<Product> _listOfSuggestedProducts = [];
  final List<Customer> _listOfSuggestedCustomers = [];

  AddOrderCubit() : super(AddOrderInitial()) {
    _loadAndInitDataFromDatabase();
  }

  void _loadAndInitDataFromDatabase() {
    int initialStock = 0;

    for (int i = 0; i < productBox!.values.length; i++) {
      /**
     * fetching those product items from database
     * that their initial stock should not be 
     * empty or (0). Because we only want to suggest
     * those items to our textfield that are in a stock.
     */
      if (productBox!.getAt(i)!.stock != initialStock) {
        _listOfSuggestedProducts.add(productBox!.getAt(i)!);
      }
    }

    /**
     * fetching customers records from database
     * for suggestions.
     */
    for (int i = 0; i < userBox!.values.length; i++) {
      _listOfSuggestedCustomers.add(userBox!.getAt(i)!);
    }
  }

  /// To add an order we are bound to get the product object
  /// by using [_getProductObjectFromDatabase] method.
  ///
  /// Because we are only getting a string from our [AddOrderScreen] textfield
  /// So we are using this [_getProductObjectFromDatabase] method just to
  /// get an actual product object so we can use those product object values
  /// on our [Order] object.
  ///
  /// Just read the code for better understanding...
  /// 
  /// #### code speaks louder than comments . . .
  Future<void> addOrder(String product, String customer) async {
    if (product.isNotEmpty && customer.isNotEmpty) {
      Product? productObject = _getProductObjectFromDatabase(product);

      if (productObject != null) {
        /**
       * setting up boolean flag to TRUE
       * because our newly created order's
       * status is pending.
       */
        await orderBox!.add(
          Order(
            customer.trim(),
            product.trim(),
            productObject.cost,
            DateTime.now(),
            DateTime.now(),
            true,
          ),
        );
      }
    }
  }

  /// Returns a [Product] type object from database.
  /// If value exists in a database a product object will be
  /// returned otherwise null value would be thrown.
  ///
  /// This method relies on [Hive] database for the
  /// retrieval of an object.
  ///
  /// `Argument:` To get an object, pass product name as an
  /// argument.
  ///
  /// `Example:`
  /// ```dart
  ///   Product? object = _getProductObjectFromDatabase("value");
  /// ```
  Product? _getProductObjectFromDatabase(String productName) {
    for (int i = 0; i < productBox!.values.length; i++) {
      if (productName.trim().toLowerCase() ==
          productBox!.getAt(i)!.name!.trim().toLowerCase()) {
        return productBox!.getAt(i)!;
      }
    }
    return null;
  }

  /// Search suggestion to find the products.
  List<Product> searchProduct(String searchProduct) {
    if (searchProduct.isNotEmpty) {
      List<Product> searchResults = _listOfSuggestedProducts
          .where((product) => product.name!
              .trim()
              .toLowerCase()
              .startsWith(searchProduct.trim().toLowerCase()))
          .toList();

      if (searchResults.isNotEmpty) {
        emit(ProductSearchResultsState(listOfProducts: searchResults));
        return searchResults;
      }
    }
    return List.empty();
  }

  /// Search suggestion to find the customers.
  List<Customer> searchCustomer(String searchCustomer) {
    if (searchCustomer.isNotEmpty) {
      List<Customer> searchResults = _listOfSuggestedCustomers
          .where((customer) => customer.username!
              .trim()
              .toLowerCase()
              .startsWith(searchCustomer.trim().toLowerCase()))
          .toList();

      if (searchResults.isNotEmpty) {
        emit(CustomerSearchResultsState(listOfCustomers: searchResults));
        return searchResults;
      }
    }
    return List.empty();
  }
}
