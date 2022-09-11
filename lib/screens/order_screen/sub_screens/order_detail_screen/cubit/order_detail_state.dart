part of 'order_detail_cubit.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState {}

class MarkOrderState extends OrderDetailState {
  // final String message;

  // const MarkOrderState(this.message);

  // @override
  // List<Object> get props => [message];
}

class UnMarkedOrderState extends OrderDetailState {  
// final String message;

  // const UnMarkedOrderState(this.message);

  // @override
  // List<Object> get props => [message];
  }
