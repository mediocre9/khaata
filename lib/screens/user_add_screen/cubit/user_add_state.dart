part of 'user_add_cubit.dart';

abstract class UserAddState {
  const UserAddState();
}

class UserAddInitialState extends UserAddState {
  UserAddInitialState();
}

class UserAddedState extends UserAddState {
  final String message;
  final Color color;
  UserAddedState({required this.message, required this.color});
}

class UserNotAddedState extends UserAddState {
  final String message;
  final Color color;
  UserNotAddedState({required this.message, required this.color});
}
