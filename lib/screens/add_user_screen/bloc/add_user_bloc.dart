import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/screens/add_user_screen/bloc/add_user_event.dart';

enum UserDataEntryState {
  initialState,
  validState,
  invalidState,
}

class AddUserBloc extends Bloc<AddUserEvent, UserDataEntryState> {
  AddUserBloc() : super(UserDataEntryState.initialState) {
    onButtonPressed();
  }

  onButtonPressed() {
    on<AddUserButtonEvent>(
      (event, emit) {
        if (event.username.toString().isNotEmpty &&
            event.address.toString().isNotEmpty) {
          userBox?.add(
              UserModel(username: event.username, address: event.address));
          emit(UserDataEntryState.validState);
        }
        emit(UserDataEntryState.invalidState);
      },
    );
  }
}
