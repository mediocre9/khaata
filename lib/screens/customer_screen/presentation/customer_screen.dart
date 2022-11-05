import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/customer.dart';
import 'package:khata/screens/customer_screen/cubit/customer_cubit.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/empty_record.dart';
import 'package:khata/widgets/tray_container.dart';
import 'package:khata/widgets/record_not_found.dart';
import 'package:khata/widgets/sub_screen_navigator_widget.dart';

/// UserScreen Widget Tree Flow:
/// 1). [CustomerScreen] is a parent node.
/// 2). Button Widget [SubScreenNavigatorButton] for next
///     (subscreen) navigation.
/// 3). Search textfield [SearchFieldAreaWidget] to search
///     the customers.
/// 4). An inset shadow container [TrayContainer] widget,
///     where our [UserCardWidget] will be displayed on.
/// 5). This [UserInterfaceStateManager] class manages the app
///     states and updates the UI when an event occurs.
class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        /**
         * Main User Screen Layout:
         * 1). [CustomAppBar] 
         * 2). [SubScreenNavigatorWidget] to navigate to new screen.
         * 3). [SearchFieldAreaWidget] to search the customers.
         * 4). [NeumorphicContainer] a custom container with neumorphic design effect.
         */
        appBar: const CustomAppBar(
          title: Text("MANAGE"),
          subtitle: Text("CUSTOMER"),
        ),
        endDrawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SubScreenNavigatorButton(
                label: "ADD CUSTOMER",
                route: '/AddCustomerScreen',
              ),
              SearchFieldAreaWidget(),
              TrayContainer(
                stateManager: UserInterfaceStateManager(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFieldAreaWidget extends StatelessWidget {
  const SearchFieldAreaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "SEARCH CUSTOMER",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: kTextColor),
            ),
            const Icon(
              Icons.search_rounded,
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          style: const TextStyle(color: kTextColor),
          decoration: const InputDecoration(hintText: "Search"),
          onChanged: (user) {
            BlocProvider.of<CustomerCubit>(context).searchUser(user);
          },
        ),
      ],
    );
  }
}

/// Screen UI state manager that updates the UI when an event occurs.
///
/// Scenario: About [CustomerScreen]
///
/// Case [CustomerInitialState] :
/// If customers are not stored in a database, then the UI state
/// would be [EmptyRecordsWidget].
///
/// Case [LoadCustomersState] :
/// If customers are stored in a database, then the UI state would
/// fetch the customers record from database and a list would be
/// generated to show the records.
///
/// Case [CustomerFoundState] :
/// If customer(s) found from their initials, then the UI state would be updated
/// and a new list of founded records would be shown.
///
/// Case [CustomerNotFoundState]
/// If customer not found, then the UI state would be [RecordNotFoundWidget]
///
class UserInterfaceStateManager extends StatelessWidget
    implements InterfaceStateManager {
  const UserInterfaceStateManager({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (_, state) {
        if (state is CustomerInitialState) {
          return EmptyRecordsWidget(
            icon: Icons.list,
            message: state.message,
          );
        } else if (state is LoadCustomersState) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: state.customers.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: (dismiss) async {
                    await BlocProvider.of<CustomerCubit>(_).deleteUser(index);
                  },
                  child: UserCardWidget(
                    customer: state.customers[index],
                    placedOrders: BlocProvider.of<CustomerCubit>(context)
                        .placedOrders(state.customers[index].username!),
                  ),
                );
              },
            ),
          );
        } else if (state is CustomerFoundState) {
          return ListView.builder(
            itemCount: state.searchResult.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return UserCardWidget(
                customer: state.searchResult[index],
                placedOrders: BlocProvider.of<CustomerCubit>(context)
                    .placedOrders(state.searchResult[index].username!),
              );
            },
          );
        } else if (state is CustomerNotFoundState) {
          return RecordNotFoundWidget(message: state.message);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class UserCardWidget extends StatelessWidget with GradientDecoration {
  final Customer customer;
  final int placedOrders;

  const UserCardWidget({
    Key? key,
    required this.placedOrders,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: gradientDecoration(),
        child: Column(
          children: [
            ListTile(
              title: Text(
                customer.username!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PLACED ORDERS : $placedOrders",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              trailing: const Icon(Icons.expand_circle_down_outlined),
              leading: const Icon(Icons.person),
              expandedAlignment: Alignment.centerLeft,
              collapsedIconColor: const Color.fromARGB(255, 218, 224, 236),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 10,
              ),
              title: Text(
                "ADDRESS",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
              ),
              children: [
                Text(
                  customer.address!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: const Color.fromARGB(255, 218, 224, 236)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
