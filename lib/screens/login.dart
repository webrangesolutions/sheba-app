// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheba_financial/screens/dashboard.dart';
import 'package:sheba_financial/screens/otp.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../helpers/ui_helper.dart';
import '../models/user_model.dart';
import '../utils/route_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: mediaHeight * 0.15,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100.0,
                ),
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
                    color:
                        AppColors.secondaryColor, // Set the text color to red
                  ),
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: AppColors.secondaryColor),
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
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
                      checkValues();
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteHelper.forgetPasswordScreen);
                  },
                  child: const Center(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.signUpRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('New User? '),
                    Text(
                      'Create Account',
                      style: TextStyle(color: AppColors.secondaryColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Please fill all the fields!"),
        ),
      );
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credentials;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // String accessToken = await credentials.user!.getIdToken();

      // // Use the access token as needed
      // print('Access token: $accessToken');
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: const Duration(seconds: 1),
          content: Text(ex.message.toString()),
        ),
      );
    }

    if (credentials != null) {
      String uid = credentials.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      UserModel.loggedinUser = userModel;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('onboarding', false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Login successfull!"),
        ),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const DashboardScreen();
          },
        ),
      );
      // if (userModel.isVerified ?? true) {
      //   Navigator.popUntil(context, (route) => route.isFirst);
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return const DashboardScreen();
      //       },
      //     ),
      //   );
      // } else {
      //   verifyPhone(userModel.phoneNo);
      // }
    }
  }

  void verifyPhone(String? phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        RouteHelper.verificationId = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OtpScreen();
            },
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
