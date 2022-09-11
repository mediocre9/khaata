import 'user_cubit_exports.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final List<UserModel> _userList = [];
  UserCubit() : super(const ManageUserInitial("EMPTY LIST")) {
    _loadUsersList();
  }

  void _loadUsersList() {
    for (int i = 0; i < userBox!.values.length; i++) {
      _userList.add(userBox!.getAt(i)!);
    }

    if (_userList.isNotEmpty) {
      emit(LoadUserDataState(users: _userList));
    } else {
      emit(const ManageUserInitial("RECORD LIST IS EMPTY!"));
    }
  }

  void searchUser(String user) {
    List<UserModel> searchList = [];
    searchList = _userList
        .where((element) =>
            element.username!.toLowerCase().startsWith(user.toLowerCase()))
        .toList();

    if (searchList.isNotEmpty) {
      emit(UserFoundState(searchUser: searchList));
    } else {
      emit(const UserNotFoundState("CUSTOMER NOT FOUND!"));
    }
  }

  Future<void> deleteUser(int index) async {
    await userBox!.deleteAt(index);
  }
}
