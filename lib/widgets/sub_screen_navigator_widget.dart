import '../screens/user_home_screen/user_home_exports.dart';

class SubScreenNavigatorWidget extends StatelessWidget {
  final String label;
  final String route;
  const SubScreenNavigatorWidget({
    Key? key,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          label: Text(label.toUpperCase()),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}