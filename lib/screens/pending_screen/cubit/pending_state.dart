part of 'pending_cubit.dart';

abstract class PendingState extends Equatable {
  const PendingState();

  @override
  List<Object> get props => [];
}

class PendingOrderInitial extends PendingState {
  final String message;
  final IconData iconData;

  const PendingOrderInitial({required this.message, required this.iconData});
}

class PendingStateCard extends PendingState {
  final List<Order> orders;

  const PendingStateCard({this.orders = const <Order>[]});

  @override
  List<Object> get props => [orders];
}
