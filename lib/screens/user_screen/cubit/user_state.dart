part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class ManageUserInitial extends UserState {
  final String message;
  const ManageUserInitial(this.message);

  // @override
  // List<Object> get props => [message];
}

class LoadUserDataState extends UserState {
  final List<UserModel> users;
  const LoadUserDataState({required this.users});

  @override
  List<Object> get props => [users];
}

class UserFoundState extends UserState {
  final List<UserModel> searchUser;
  const UserFoundState({required this.searchUser});

  @override
  List<Object> get props => [searchUser];
}

class UserNotFoundState extends UserState {
  final String message;
  const UserNotFoundState(this.message);

  @override
  List<Object> get props => [message];
}

class ManageUserLoadingState extends UserState {}
