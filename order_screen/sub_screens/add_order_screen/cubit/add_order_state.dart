part of 'add_order_cubit.dart';

abstract class AddOrderState {
  const AddOrderState();
}

class AddOrderInitial extends AddOrderState {}

class ProductSearchResultsState extends AddOrderState {
  final List<Product> listOfProducts;

  ProductSearchResultsState({required this.listOfProducts});
}

class CustomerSearchResultsState extends AddOrderState {
  final List<Customer> listOfCustomers;

  CustomerSearchResultsState({required this.listOfCustomers});
}

class OrderSelectedState extends AddOrderState {}

class CustomerSelectedState extends AddOrderState {}
