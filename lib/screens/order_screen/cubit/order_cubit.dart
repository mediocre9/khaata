import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final List<Order> orders = [];
  OrderCubit()
      : super(
          const OrderInitialState(
            message: "ORDER LIST IS EMPTY!",
            icon: Icons.list,
          ),
        ) {
    _loadOrdersfromDatabase();
  }

  void _loadOrdersfromDatabase() {
    for (int i = 0; i < orderBox!.values.length; i++) {
      orders.add(orderBox!.getAt(i)!);
    }

    if (orders.isNotEmpty) {
      emit(OrderLoadState(listOfOrders: orders));
    }
  }

  get totalPendingOrders {
    int count = 0;
    bool isOrderPending = true;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus == isOrderPending) {
        count++;
      }
    }
    return count;
  }

  get totalGainedMoney {
    int money = 0;
    bool isOrderPending = false;

    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus == isOrderPending) {
        money = money + orderBox!.getAt(i)!.cost!;
      }
    }
    return money;
  }

  void searchOrder(String searchOrder) {
    List<Order> searchResults = orders
        .where((order) => order.productName!
            .trim()
            .toLowerCase()
            .startsWith(searchOrder.trim().toLowerCase()))
        .toList();

    if (searchResults.isNotEmpty) {
      emit(OrderSearchState(listOfOrders: searchResults));
    } else {
      emit(
        const OrderFoundState(
          message: "ORDER NOT FOUND!",
          icon: Icons.search_off_rounded,
        ),
      );
    }
  }

  get totalOrders => orders.length;
}
