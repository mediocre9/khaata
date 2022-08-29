import 'user_home_exports.dart';

// Main  stateless root widget.....
class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);
  final TextEditingController _search = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
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
                      label: const Text("ADD USER",
                          style: TextStyle(color: kTextColor)),
                      icon: const Icon(Icons.add, color: kTextColor),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "SEARCH USER",
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ),
                        ),
                        Icon(Icons.search_rounded, size: 14)
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: "Search",
                      borderRadius: 4,
                      isDense: true,
                      contentPadding: 8,
                      onChanged: (user) {
                        BlocProvider.of<UserHomeCubit>(context)
                            .searchUser(user);
                      },
                      controller: _search,
                    ),
                  ],
                ),
                const UserListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  const UserListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color.fromARGB(255, 253, 253, 253),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.4,
              blurRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 65, 65, 65),
              spreadRadius: 1.5,
              blurRadius: 4,
              offset: Offset(1, 4),
              inset: true,
            )
          ],
        ),
        child: BlocBuilder<UserHomeCubit, ManageUserState>(
          builder: (_, state) {
            if (state is ManageUserInitial) {
              return EmptyRecordsWidget(
                  icon: Icons.list, message: state.message);
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
                      username: state.users[index].username,
                      address: state.users[index].address,
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
                    username: state.searchUser[index].username,
                    address: state.searchUser[index].address,
                  );
                },
              );
            } else if (state is UserNotFoundState) {
              return UserNotFoundWidget(message: state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  const UserCardWidget(
      {Key? key, required this.username, required this.address})
      : super(key: key);
  final String? username, address;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: CustomCard(
        borderRadius: 7,
        shadow: false,
        width: double.maxFinite,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                username!,
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
                  Text(
                    "ADDRESS : ${address!}",
                    style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.1,
                      color: kCardTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "TOTAL PLACED ORDERS :",
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.1,
                      color: kCardTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserNotFoundWidget extends StatelessWidget {
  const UserNotFoundWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      ),
    );
  }
}

class EmptyRecordsWidget extends StatelessWidget {
  const EmptyRecordsWidget({
    Key? key,
    required this.icon,
    required this.message,
  }) : super(key: key);

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 65,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    );
  }
}
