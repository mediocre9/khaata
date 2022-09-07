import 'package:khata/screens/add_item_screen/cubit/add_item_cubit.dart';
import 'package:khata/screens/user_home_screen/user_home_exports.dart';
import 'package:khata/widgets/custom_outlined_button.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Order",
          subTitle: "Book",
          titleFontSize: 23,
        ),
        endDrawer: const CustomDrawer(),
        body: CustomCard(
          innerMainAlignment: MainAxisAlignment.center,
          verticalMargin: 15,
          horizontalMargin: 30,
          elevationLevel: 5,
          borderRadius: 5,
          height: 400,
          width: double.maxFinite,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.white60,
                      iconSize: 22,
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/manageInventoryScreen');
                      },
                    ),
                  ],
                ),
              ),
              const Text(
                "ADD ITEM",
                style: TextStyle(
                  fontSize: 20,
                  color: kCardTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: const SaveItemData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaveItemData extends StatelessWidget {
  const SaveItemData({Key? key}) : super(key: key);
  static final TextEditingController _itemNameController =
      TextEditingController();
  static final TextEditingController _stockControlller =
      TextEditingController();

  static final TextEditingController _costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: BlocListener<AddItemCubit, AddItemState>(
        listener: (context, state) {
          if (state is ItemAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              _showSnackBar(
                state.message,
                state.color,
              ),
            );
            clearController();
          } else if (state is ItemNotAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              _showSnackBar(
                state.message,
                state.color,
              ),
            );
          } else if (state is ItemAlreadyExist) {
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
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("NAME",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  CustomTextField(
                    isDense: true,
                    contentPadding: 10,
                    color: kCardTextColor,
                    inputType: TextInputType.name,
                    controller: _itemNameController,
                    borderStyle: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3)),
                    onChanged: (s) {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "INITIAL STOCK",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    isDense: true,
                    contentPadding: 10,
                    maxLength: 10,
                    counterStyle: Colors.white,
                    color: kCardTextColor,
                    controller: _stockControlller,
                    inputType: TextInputType.number,
                    borderStyle: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3),
                    ),
                    onChanged: (s) {},
                  ),
                ],
              ),
            ),

            // separation
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "COST",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    isDense: true,
                    contentPadding: 10,
                    maxLength: 10,
                    color: kCardTextColor,
                    counterStyle: Colors.white,
                    controller: _costController,
                    inputType: TextInputType.number,
                    borderStyle: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3),
                    ),
                    onChanged: (s) {},
                  ),
                ],
              ),
            ),

            // separation
            Center(
              child: CustomOutlinedButton(
                text: "ADD ITEM",
                textColor: kCardTextColor,
                onPressed: () {
                  BlocProvider.of<AddItemCubit>(context).addItem(
                    _itemNameController.text,
                    _stockControlller.text,
                    _costController.text,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearController() {
    _itemNameController.clear();
    _costController.clear();
    _stockControlller.clear();
  }

  SnackBar _showSnackBar(String? message, Color? color) {
    return SnackBar(
      duration: const Duration(milliseconds: 600),
      key: UniqueKey(),
      content: Text(message ?? "Value not defined",
          style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color ?? Colors.blueAccent,
    );
  }
}
