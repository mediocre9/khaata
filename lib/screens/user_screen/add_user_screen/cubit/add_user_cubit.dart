import 'package:bloc/bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/screens/user_screen/add_user_screen/cubit/add_user_state.dart';


class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(UserAddInitialState());

  void addUser(String username, String address) async {
    if (username.isNotEmpty && address.isNotEmpty) {
      await userBox!.add(UserModel(username: username, address: address));
      emit(UserAddedState(
          message: "User has been successfully added!",
          color: kSnackBarSuccessColor));
    } else {
      emit(UserNotAddedState(
          message: "Please fill all the given fields!",
          color: kSnackBarErrorColor));
    }
  }
}
