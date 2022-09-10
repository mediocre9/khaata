import 'package:flutter/material.dart';

class RecordNotFoundWidget extends StatelessWidget {
  const RecordNotFoundWidget({
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