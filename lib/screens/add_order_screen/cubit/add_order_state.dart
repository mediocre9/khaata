part of 'add_order_cubit.dart';

abstract class AddOrderState {
  const AddOrderState();
}

class AddOrderInitial extends AddOrderState {}

class ProductSearchState extends AddOrderState {
  final List<ProductModel> products;

  ProductSearchState(this.products);
}

class CustomerSearchState extends AddOrderState {
  final List<UserModel> customers;

  CustomerSearchState(this.customers);
}

class OrderSelectedState extends AddOrderState {}

class CustomerSelectedState extends AddOrderState {}
