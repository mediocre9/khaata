part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderHomeInitial extends OrderState {
  final String message;
  final IconData iconData;
  const OrderHomeInitial({required this.message, required this.iconData});
}

class OrderLoadState extends OrderState {
  final List<Order> orderModel;
  const OrderLoadState({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class OrderSearchState extends OrderState {
  final List<Order> orderModel;
  const OrderSearchState({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class OrderFoundState extends OrderState {
  final String message;
  final IconData iconData;
  const OrderFoundState({required this.message, required this.iconData});
}

class OrderCompletedState extends OrderState {
  final IconData iconData;
  const OrderCompletedState({required this.iconData});
}

class OrderNotCompletedState extends OrderState {
  final IconData iconData;
  const OrderNotCompletedState({required this.iconData});
}
