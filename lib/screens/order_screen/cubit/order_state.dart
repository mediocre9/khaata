part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {
  final String message;
  final IconData icon;
  const OrderInitialState({required this.message, required this.icon});
}

class OrderLoadState extends OrderState {
  final List<Order> listOfOrders;
  const OrderLoadState({required this.listOfOrders});

  @override
  List<Object> get props => [listOfOrders];
}

class OrderSearchState extends OrderState {
  final List<Order> listOfOrders;
  const OrderSearchState({required this.listOfOrders});

  @override
  List<Object> get props => [listOfOrders];
}

class OrderFoundState extends OrderState {
  final String message;
  final IconData icon;
  const OrderFoundState({required this.message, required this.icon});
}

class OrderCompletedState extends OrderState {
  final IconData iconData;
  const OrderCompletedState({required this.iconData});
}

class OrderNotCompletedState extends OrderState {
  final IconData iconData;
  const OrderNotCompletedState({required this.iconData});
}
