import 'user_home_exports.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  static final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            CustomAppBar(title: "Manage", titleFontSize: 23, subTitle: "User"),
        endDrawer: const CustomDrawer(),
        body: SafeArea(
          child: Container(
            color: kScaffoldColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addUserNavigationButton(context),
                _searchField(context),
                const UserListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _addUserNavigationButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          label: const Text(
            "ADD USER",
            style: TextStyle(color: kTextColor),
          ),
          icon: const Icon(Icons.add, color: kTextColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => UserAddCubit(),
                  child: const UserAddSubScreen(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Column _searchField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTextFieldLabel(data: "SEARCH CUSTOMER"),
        const SizedBox(height: 4),
        CustomTextField(
          hintText: "Search",
          borderRadius: 4,
          isDense: true,
          contentPadding: 8,
          onChanged: (user) {
            BlocProvider.of<UserHomeCubit>(context).searchUser(user);
          },
          controller: _search,
        ),
      ],
    );
  }
}

class UserListView extends StatelessWidget with NeumorphicTray {
  const UserListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 30),
        decoration: neumorphicTrayDecoration(),
        child: BlocBuilder<UserHomeCubit, ManageUserState>(
          builder: (_, state) {
            if (state is ManageUserInitial) {
              return EmptyRecordsWidget(
                icon: Icons.list,
                message: state.message,
              );
            } else if (state is LoadUserDataState) {
              return ListView.builder(
                itemCount: state.users.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (dismiss) =>
                        BlocProvider.of<UserHomeCubit>(_).deleteUser(index),
                    child: UserCardWidget(
                      username: state.users[index].username!,
                      address: state.users[index].address!,
                    ),
                  );
                },
              );
            } else if (state is UserFoundState) {
              return ListView.builder(
                itemCount: state.searchUser.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return UserCardWidget(
                    username: state.searchUser[index].username!,
                    address: state.searchUser[index].address!,
                  );
                },
              );
            } else if (state is UserNotFoundState) {
              return DataNotFoundWidget(message: state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    Key? key,
    required this.username,
    required this.address,
  }) : super(key: key);

  final String username;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: CustomCard(
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                username.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  color: kCardTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              dense: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3),
                  _userDetailView("ADDRESS : ${address.toUpperCase()}"),
                  const SizedBox(height: 3),
                  _userDetailView("TOTAL PLACED ORDERS : "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _userDetailView(String data) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 10,
        letterSpacing: 1.1,
        color: kCardTextColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
