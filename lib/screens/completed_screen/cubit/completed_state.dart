part of 'completed_cubit.dart';

abstract class CompletedState extends Equatable {
  const CompletedState();

  @override
  List<Object> get props => [];
}

class OrderCompleteInitial extends CompletedState {
  final String message;
  final IconData iconData;

  const OrderCompleteInitial(this.message, this.iconData);
}

class CompletedOrdersState extends CompletedState {
  final List<OrderModel> orders;

  const CompletedOrdersState(this.orders);

  @override
  List<Object> get props => [orders];
}
