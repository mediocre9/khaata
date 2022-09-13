import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/order.dart';

part 'pending_state.dart';

class PendingCubit extends Cubit<PendingState> {
  final List<Order> pendingOrders = [];
  final bool isOrderPending = true;

  PendingCubit()
      : super(const PendingOrderInitial(
            message: "PENDING ORDER LIST IS EMPTY!", iconData: Icons.list)) {
    _loadPendingOrders();
  }

  get totalPendingOrders => pendingOrders.length;

  get pendingMoney {
    int remainingMoney = 0;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == isOrderPending) {
        remainingMoney = remainingMoney + orderBox!.getAt(i)!.cost!;
      }
    }
    return remainingMoney;
  }

  _loadPendingOrders() {
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.status == isOrderPending) {
        pendingOrders.add(orderBox!.getAt(i)!);
      }
    }
    if (pendingOrders.isNotEmpty) {
      emit(PendingStateCard(orders: pendingOrders));
    }
  }
}
