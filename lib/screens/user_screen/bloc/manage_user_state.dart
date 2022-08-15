part of 'manage_user_bloc.dart';

abstract class ManageUserState {
  const ManageUserState();
}

class ManageUserInitial extends ManageUserState {
  final String? message;
  final IconData? icon;
  const ManageUserInitial(this.message, this.icon);
}

class ManageUserFoundState extends ManageUserState {
  List<UserModel?> get usersList {
    List<UserModel?> userList = [];
    for (int i = 0; i < userBox!.values.length; i++) {
      userList.add(userBox!.getAt(i));
    }
    return userList;
  }
}

class ManageUserNotFoundState extends ManageUserState {
  final String? message;
  final IconData? icon;
  const ManageUserNotFoundState(this.message, this.icon);
}
