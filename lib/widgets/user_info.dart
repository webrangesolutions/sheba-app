import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
        SizedBox(width: 50),
        Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }
}
