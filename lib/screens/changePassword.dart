import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheba_financial/screens/login.dart';
import 'package:sheba_financial/utils/color_constants.dart';

class ChnagePasswordScreen extends StatefulWidget {
  const ChnagePasswordScreen({super.key});

  @override
  State<ChnagePasswordScreen> createState() => _ChnagePasswordScreenState();
}

class _ChnagePasswordScreenState extends State<ChnagePasswordScreen> {
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
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: mediaWidth * 0.04),
                      const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: mediaHeight * 0.15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: const TextStyle(
                        color: AppColors
                            .secondaryColor, // Set the text color to red
                      ),
                      controller: _emailController,
                      decoration: const InputDecoration(
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
                        onPressed: () async {
                          resetPass();
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 32, 131, 37)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }

  void resetPass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim())
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              duration: const Duration(seconds: 1),
              content:
                  Text("Reset link sent on ${_emailController.text.trim()}!"),
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ),
          );
        },
      );
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: const Duration(seconds: 1),
          content: Text(ex.message.toString()),
        ),
      );
    }
  }
}
