import 'customer_cubit_exports.dart';
part 'customer_state.dart';

class UserCubit extends Cubit<CustomerState> {
  final List<Customer> _userList = [];
  UserCubit() : super(const CustomerInitialState("EMPTY LIST")) {
    _loadUsersList();
  }

  void _loadUsersList() {
    for (int i = 0; i < userBox!.values.length; i++) {
      _userList.add(userBox!.getAt(i)!);
    }

    if (_userList.isNotEmpty) {
      emit(LoadCustomersState(users: _userList));
    } else {
      emit(const CustomerInitialState("RECORD LIST IS EMPTY!"));
    }
  }

  void searchUser(String user) {
    List<Customer> searchList = [];
    searchList = _userList
        .where((customer) =>
            customer.username!.toLowerCase().startsWith(user.toLowerCase()))
        .toList();

    if (searchList.isNotEmpty) {
      emit(CustomerFoundState(searchUser: searchList));
    } else {
      emit(const CustomerNotFoundState("CUSTOMER NOT FOUND!"));
    }
  }

  Future<void> deleteUser(int index) async {
    await userBox!.deleteAt(index);
  }
}
