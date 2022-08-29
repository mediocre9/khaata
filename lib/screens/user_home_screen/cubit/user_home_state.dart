part of 'user_home_cubit.dart';

abstract class ManageUserState extends Equatable {
  const ManageUserState();

  @override
  List<Object> get props => [];
}

class ManageUserInitial extends ManageUserState {
  final String message;
  const ManageUserInitial(this.message);

  // @override
  // List<Object> get props => [message];
}

class LoadUserDataState extends ManageUserState {
  final List<UserModel> users;
  const LoadUserDataState({required this.users});

  @override
  List<Object> get props => [users];
}

class UserFoundState extends ManageUserState {
  final List<UserModel> searchUser;
  const UserFoundState({required this.searchUser});

  @override
  List<Object> get props => [searchUser];
}

class UserNotFoundState extends ManageUserState {
  final String message;
  const UserNotFoundState(this.message);

  @override
  List<Object> get props => [message];
}

class ManageUserLoadingState extends ManageUserState {}
