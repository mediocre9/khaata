part of 'order_detail_cubit.dart';

abstract class OrderDetailState{
  const OrderDetailState();

  // @override
  // List<Object> get props => [];
}

class OrderDetailInitialState extends OrderDetailState {}

class MarkOrderState extends OrderDetailState {}

class UnMarkedOrderState extends OrderDetailState {}
