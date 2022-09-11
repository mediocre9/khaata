




import 'package:flutter/material.dart';

abstract class AddUserState {
  const AddUserState();
}

class UserAddInitialState extends AddUserState {
  UserAddInitialState();
}

class UserAddedState extends AddUserState {
  final String message;
  final Color color;
  UserAddedState({required this.message, required this.color});
}

class UserNotAddedState extends AddUserState {
  final String message;
  final Color color;
  UserNotAddedState({required this.message, required this.color});
}
