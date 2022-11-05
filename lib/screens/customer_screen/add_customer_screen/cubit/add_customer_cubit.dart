import 'package:bloc/bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/customer.dart';
import 'package:khata/screens/customer_screen/add_customer_screen/cubit/add_customer_state.dart';

class AddCustomerCubit extends Cubit<CustomerSaveState> {
  AddCustomerCubit() : super(CustomerSaveInitialState());

  void addUser(String username, String address) async {
    if (username.isNotEmpty && address.isNotEmpty) {
      await customerBox!.add(
        Customer(
          username: username.trim().toUpperCase(),
          address: address.trim().toUpperCase(),
        ),
      );
      emit(
        CustomerSavedState(
          message: "User has been successfully added!",
          color: kSnackBarSuccessColor,
        ),
      );
    } else {
      emit(
        CustomerNotSavedState(
          message: "Please fill out all the given fields!",
          color: kSnackBarErrorColor,
        ),
      );
    }
  }
}
