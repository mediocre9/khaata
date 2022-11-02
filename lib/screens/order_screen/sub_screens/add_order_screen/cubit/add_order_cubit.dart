import 'package:flutter/foundation.dart';
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
    for (int i = 0; i < productBox!.values.length; i++) {
      /**
     * fetching those product items from database
     * that their initial stock should not be 
     * empty or (0). Because we only want to suggest
     * those items to our textfield that are in a stock.
     */
      if (productBox!.getAt(i)!.stock != 0) {
        _listOfSuggestedProducts.add(productBox!.getAt(i)!);
      }
    }

    /**
     * fetching customers records from database
     * for suggestions.
     */
    for (int i = 0; i < customerBox!.values.length; i++) {
      _listOfSuggestedCustomers.add(customerBox!.getAt(i)!);
    }
  }

  /// To add an order we are bound to get the product object
  /// by using [_getProductObjectFromDatabase] method.
  ///
  /// Because we are only getting a string from our [AddOrderScreen]'s textfields
  /// So we are using this [_getProductObjectFromDatabase] method just to
  /// get an actual product object by finding it through product name.
  /// so we can use that product object on our [Order] object.
  ///
  /// Just read the code for better understanding...
  Future<void> addOrder(String product, String customer) async {
    if (product.isNotEmpty && customer.isNotEmpty) {
      Product? productObject = _getProductObjectFromDatabase(product);

      if (productObject != null) {
        /**
       * setting up boolean flag to TRUE
       * because our newly created order's
       * status should be in a pending
       * state.
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
  /// returned otherwise null value would be thrown out.
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

  /// generic search method to find customer or product object....
  List<T> search<T>(String search) {
    if (search.isNotEmpty) {
      List<T> searchResults = [];
      AddOrderState state;

      if (T == Customer) {
        searchResults = _listOfSuggestedCustomers
            .where((customer) => customer.username!
                .trim()
                .toLowerCase()
                .startsWith(search.trim().toLowerCase()))
            .cast<T>()
            .toList();

        state = CustomerSearchResultsState(listOfCustomers: searchResults.cast());
      } else {
        searchResults = _listOfSuggestedProducts
            .where((product) => product.name!
                .trim()
                .toLowerCase()
                .startsWith(search.trim().toLowerCase()))
            .cast<T>()
            .toList();

        state = ProductSearchResultsState(listOfProducts: searchResults.cast());
      }

      /***
       * If the list of suggested [searchResults] is not empty
       * then emit a new state, Otherwise an empty list would be 
       * returned.
       */
      if (searchResults.isNotEmpty) {
        emit(state);
        return searchResults;
      }
    }

    if (kDebugMode) {
      print("Search results not found!");
    }
    return List.empty();
  }
}
