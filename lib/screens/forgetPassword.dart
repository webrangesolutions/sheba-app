import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../utils/route_helper.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _passwordVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaHeight * 0.13,
                  ),
                  Row(
                    children: [
                      SizedBox(width: mediaWidth * 0.02),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: mediaWidth * 0.04),
                      Text(
                        'Forget Password',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: mediaHeight * 0.15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(
                        color: AppColors
                            .secondaryColor, // Set the text color to red
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.trim() ==
                                  'admin@gmail.com' &&
                              _passwordController.text.trim() == 'abcd1234') {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteHelper.usersRoute,
                                (Route<dynamic> route) => false);
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteHelper.dashboardRoute,
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 32, 131, 37)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
