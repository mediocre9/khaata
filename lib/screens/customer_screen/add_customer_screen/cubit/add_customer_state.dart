import 'package:flutter/material.dart';

abstract class CustomerSaveState {
  const CustomerSaveState();
}

class CustomerSaveInitialState extends CustomerSaveState {
  CustomerSaveInitialState();
}

class CustomerSavedState extends CustomerSaveState {
  final String message;
  final Color color;
  CustomerSavedState({required this.message, required this.color});
}

class CustomerNotSavedState extends CustomerSaveState {
  final String message;
  final Color color;
  CustomerNotSavedState({required this.message, required this.color});
}
