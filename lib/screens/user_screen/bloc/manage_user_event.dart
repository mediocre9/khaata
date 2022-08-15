part of 'manage_user_bloc.dart';

abstract class ManageUserEvent {
  const ManageUserEvent();
}

// class AddUserNavigationEvent extends ManageUserEvent {}

class ManageSearchUserEvent extends ManageUserEvent {
  final String? username;

  ManageSearchUserEvent(this.username);
}
