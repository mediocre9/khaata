part of 'order_home_cubit.dart';

abstract class OrderHomeState extends Equatable {
  const OrderHomeState();

  @override
  List<Object> get props => [];
}

class OrderHomeInitial extends OrderHomeState {
  final String message;
  final IconData iconData;
  const OrderHomeInitial({required this.message, required this.iconData});
}

class OrderLoadState extends OrderHomeState {
  final List<OrderModel> orderModel;
  const OrderLoadState({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class OrderSearchState extends OrderHomeState {
  final List<OrderModel> orderModel;
  const OrderSearchState({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

class OrderFoundState extends OrderHomeState {
  final String message;
  final IconData iconData;
  const OrderFoundState({required this.message, required this.iconData});
}

class OrderCompletedState extends OrderHomeState {
  final IconData iconData;
  const OrderCompletedState({required this.iconData});
}

class OrderNotCompletedState extends OrderHomeState {
  final IconData iconData;
  const OrderNotCompletedState({required this.iconData});
}
