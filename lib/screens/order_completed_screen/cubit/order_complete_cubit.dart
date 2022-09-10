import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order_model.dart';

part 'order_complete_state.dart';

class OrderCompleteCubit extends Cubit<OrderCompleteState> {
  final List<OrderModel> orders = [];
  final bool _isOrderPending = false;
  OrderCompleteCubit()
      : super(const OrderCompleteInitial("0 ORDERS", Icons.list)) {
    _loadCompletedOrders();
  }

  get totalCompletedOrders => orders.length;

  get completedGainMoney {
    int gainMoney = 0;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == _isOrderPending) {
        gainMoney = gainMoney + orderBox!.getAt(i)!.cost!;
      }
    }
    return gainMoney;
  }

  _loadCompletedOrders() {
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == _isOrderPending) {
        orders.add(orderBox!.getAt(i)!);
      }
    }
    if (orders.isNotEmpty) {
      emit(CompletedOrdersState(orders));
    }
  }
}
