import 'package:bloc/bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/customer.dart';
import 'package:khata/screens/user_screen/add_customer_screen/cubit/add_customer_state.dart';

class AddUserCubit extends Cubit<CustomerSaveState> {
  AddUserCubit() : super(CustomerSaveInitialState());

  void addUser(String username, String address) async {
    if (username.isNotEmpty && address.isNotEmpty) {
      await userBox!.add(Customer(username: username, address: address));
      emit(
        CustomerSavedState(
          message: "User has been successfully added!",
          color: kSnackBarSuccessColor,
        ),
      );
    } else {
      emit(
        CustomerNotSavedState(
          message: "Please fill all the given fields!",
          color: kSnackBarErrorColor,
        ),
      );
    }
  }
}
