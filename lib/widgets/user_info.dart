import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String label;
  String value;
  UserInfo(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
