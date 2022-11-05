import 'customer_cubit_exports.dart';
part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final List<Customer> _listOfCustomers = [];
  CustomerCubit() : super(const CustomerInitialState("EMPTY LIST")) {
    _loadCustomers();
  }

  void _loadCustomers() {
    for (int i = 0; i < customerBox!.values.length; i++) {
      _listOfCustomers.add(customerBox!.getAt(i)!);
    }

    if (_listOfCustomers.isNotEmpty) {
      emit(LoadCustomersState(customers: _listOfCustomers));
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
    List<Customer> searchedCustomers = [];
    searchedCustomers = _listOfCustomers
        .where((customer) =>
            customer.username!.toLowerCase().startsWith(user.toLowerCase()))
        .toList();

    if (searchedCustomers.isNotEmpty) {
      emit(CustomerFoundState(searchResult: searchedCustomers));
    } else {
      emit(const CustomerNotFoundState("CUSTOMER NOT FOUND!"));
    }
  }

  Future<void> deleteUser(int index) async {
    await customerBox!.deleteAt(index);
  }
}
