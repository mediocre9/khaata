import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserBloc extends Bloc<ManageUserEvent, ManageUserState> {
  static List<UserModel?> storedUsers = [];
  static List<UserModel?> searchedUsers = [];
  static int? totalUsers = userBox!.values.length;
  static bool? isUserFound = false;

  ManageUserBloc()
      : super(const ManageUserInitial("RECORD LIST IS EMPTY!", Icons.list)) {
    _fetchAllUsers();

    on<ManageSearchUserEvent>((event, emit) {
      for (var user in storedUsers) {
        if (user!.username!
                .toLowerCase()
                .startsWith(event.username!.toLowerCase()) &&
            event.username!.isNotEmpty) {
          isUserFound = true;
        }
      }

      if (isUserFound!) {
        emit(ManageUserFoundState());
        isUserFound = false;
      } else {
        emit(
            const ManageUserNotFoundState("User Not Found!", Icons.search_off));
        isUserFound = false;
      }
    });
  }

  static void _fetchAllUsers() {
    for (int i = 0; i < totalUsers!; i++) {
      storedUsers.add(userBox!.getAt(i));
    }
  }
}
