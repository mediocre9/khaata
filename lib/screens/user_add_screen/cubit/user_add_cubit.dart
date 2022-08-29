import 'package:khata/models/model/user_model.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';

part 'user_add_state.dart';

class UserAddCubit extends Cubit<UserAddState> {
  UserAddCubit() : super(UserAddInitialState());

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
