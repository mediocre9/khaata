part of 'pending_order_cubit.dart';

abstract class PendingOrderState extends Equatable {
  const PendingOrderState();

  @override
  List<Object> get props => [];
}

class PendingOrderInitial extends PendingOrderState {
  final String message;
  final IconData iconData;

  const PendingOrderInitial({required this.message, required this.iconData});
}

class PendingOrderStateCard extends PendingOrderState {
  final List<OrderModel> orders;

  const PendingOrderStateCard({this.orders = const <OrderModel>[]});

  @override
  List<Object> get props => [orders];
}
