import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/screens/user_screen/bloc/user_event.dart';
import 'package:khata/screens/user_screen/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static List<UserModel?> searchList = [];
  static List<UserModel?> userList = [];

  UserBloc() : super(InitialState()) {
    fetchAllData();

    on<SearchEvent>((event, emit) {
      searchList = userList
          .where((user) => user!.username!
              .toLowerCase()
              .contains(event.searchParam!.toLowerCase()))
          .toList();
    });
  }

  fetchAllData() {
    userList.clear();
    for (var i = 0; i < userBox!.values.length; i++) {
      userList.add(userBox!.getAt(i));
    }
    searchList = userList;
  }
}
