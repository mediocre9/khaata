import 'customer_cubit_exports.dart';
part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final List<Customer> _userList = [];
  CustomerCubit() : super(const CustomerInitialState("EMPTY LIST")) {
    _loadUsersList();
  }

  void _loadUsersList() {
    for (int i = 0; i < customerBox!.values.length; i++) {
      _userList.add(customerBox!.getAt(i)!);
    }

    if (_userList.isNotEmpty) {
      emit(LoadCustomersState(users: _userList));
    } else {
      emit(const CustomerInitialState("RECORD LIST IS EMPTY!"));
    }
  }

  int placedOrders(String customer) {
    int count = 0;
    for (int i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus! == false &&
          orderBox!.getAt(i)!.customerName!.trim().toLowerCase() ==
              customer.trim().toLowerCase()) {
        count++;
      }
    }
    return count;
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
    await customerBox!.deleteAt(index);
  }
}
