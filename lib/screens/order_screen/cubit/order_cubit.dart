import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final List<Order> orders = [];
  OrderCubit()
      : super(const OrderHomeInitial(
            message: "ORDER LIST IS EMPTY!", iconData: Icons.list)) {
    _loadOrders();
  }

  get totalOrders => orders.length;

  get orderListObject => orders;

  get totalPendingOrders {
    int counter = 0;
    bool isPending = true;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == isPending) {
        counter++;
      }
    }
    return counter;
  }

  get totalGain {
    int totalMoney = 0;
    bool isCompleted = false;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == isCompleted) {
        totalMoney = totalMoney + orderBox!.getAt(i)!.cost!;
      }
    }
    return totalMoney;
  }

  void _loadOrders() {
    for (int i = 0; i < orderBox!.values.length; i++) {
      orders.add(orderBox!.getAt(i)!);
    }

    if (orders.isNotEmpty) {
      emit(OrderLoadState(orderModel: orders));
    }
  }

  void calculateCompletedOrders() {}

  void searchOrder(String search) {
    List<Order> searchOrders = orders
        .where((order) =>
            order.productname!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();

    if (searchOrders.isNotEmpty) {
      emit(OrderSearchState(orderModel: searchOrders));
    } else {
      emit(const OrderFoundState(
          message: "ORDER NOT FOUND!", iconData: Icons.search_off_rounded));
    }
  }
}
