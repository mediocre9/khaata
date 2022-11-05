import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_card.dart';
import 'package:khata/widgets/custom_drawer.dart';
import 'package:khata/widgets/custom_text_field.dart';

import '../cubit/add_customer_cubit.dart';
import '../cubit/add_customer_state.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("ORDER"),
        subtitle: Text("BOOK"),
      ),

      // Drawer
      endDrawer: const CustomDrawer(),
      body: CustomCard(
        innerMainAlignment: MainAxisAlignment.center,
        width: double.maxFinite,
        height: 310,
        verticalMargin: 3,
        horizontalMargin: 30,
        elevationLevel: 5,
        borderRadius: 5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.white60,
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/UserScreen');
                  },
                ),
              ],
            ),
            const Text(
              "ADD USER",
              style: TextStyle(
                fontSize: 24,
                color: kCardTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SaveUserData(),
          ],
        ),
      ),
    );
  }
}

class SaveUserData extends StatelessWidget {
  const SaveUserData({Key? key}) : super(key: key);

  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.zero,
      child: BlocListener<AddCustomerCubit, CustomerSaveState>(
        listener: (context, state) {
          if (state is CustomerSavedState) {
            _clearController();
            ScaffoldMessenger.of(context).showSnackBar(
              _showSnackBar(
                state.message,
                state.color,
              ),
            );
          } else if (state is CustomerNotSavedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              _showSnackBar(
                state.message,
                state.color,
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "NAME",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              isDense: true,
              contentPadding: 10,
              color: kCardTextColor,
              inputType: TextInputType.name,
              controller: _username,
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            const Text(
              "ADDRESS",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              isDense: true,
              contentPadding: 10,
              color: kCardTextColor,
              controller: _address,
              inputType: TextInputType.text,
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                child: const Text("ADD USER"),
                onPressed: () {
                  BlocProvider.of<AddCustomerCubit>(context).addUser(
                    _username.text,
                    _address.text,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearController() {
    _address.clear();
    _username.clear();
  }

  SnackBar _showSnackBar(String? message, Color? color) {
    return SnackBar(
      key: UniqueKey(),
      backgroundColor: color ?? Colors.blueAccent,
      duration: const Duration(seconds: 1),
      content: Text(
        message ?? "Value not defined",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
