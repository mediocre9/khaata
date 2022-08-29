part of 'add_order_cubit.dart';

abstract class AddOrderState {
  const AddOrderState();
}

class AddOrderInitial extends AddOrderState {}

class OrderSelectedState extends AddOrderState {}

class CustomerSelectedState extends AddOrderState {}
