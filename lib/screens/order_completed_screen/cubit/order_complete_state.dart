part of 'order_complete_cubit.dart';

abstract class OrderCompleteState extends Equatable {
  const OrderCompleteState();

  @override
  List<Object> get props => [];
}

class OrderCompleteInitial extends OrderCompleteState {
  final String message;
  final IconData iconData;

  const OrderCompleteInitial(this.message, this.iconData);
}

class CompletedOrdersState extends OrderCompleteState {
  final List<OrderModel> orders;

  const CompletedOrdersState(this.orders);

  @override
  List<Object> get props => [orders];
}
