import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  final String text;
  const TestingScreen({super.key, required this.text});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                widget.text,
              ),
            )
          ],
        ),
      ),
    );
  }
}
