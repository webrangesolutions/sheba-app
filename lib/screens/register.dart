import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheba_financial/screens/login.dart';
import 'package:sheba_financial/screens/otp.dart';
import '../models/user_model.dart';
import '../utils/color_constants.dart';
import '../utils/route_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  String countryCode = '+92';

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: mediaHeight * 0.1),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100.0,
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              TextField(
                controller: nameController,
                style: const TextStyle(
                  color: AppColors.secondaryColor, // Set the text color to red
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(
                  color: AppColors.secondaryColor, // Set the text color to red
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Company ID',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              TextField(
                controller: companyIdController,
                style: const TextStyle(
                  color: AppColors.secondaryColor, // Set the text color to red
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: InternationalPhoneNumberInput(
                        textStyle:
                            const TextStyle(color: AppColors.secondaryColor),
                        initialValue: PhoneNumber(isoCode: 'PK'),
                        onInputChanged: (PhoneNumber number) {
                          print('code: ${number.phoneNumber}');
                          countryCode = number.phoneNumber ?? '+92';
                        },
                        onInputValidated: (bool value) {
                          print('validated: $value');
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        onFieldSubmitted: (value) {
                          // print(value);
                        },
                        onSaved: (PhoneNumber number) {
                          // print(number.phoneNumber);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: phoneController,
                      // maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '33xxxxxxxx',
                        hintStyle: TextStyle(
                          fontSize: 16.0,

                          color: Colors.black45, // Set the text color to red
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16.0,

                  color: AppColors.secondaryColor, // Set the text color to red
                ),
              ),
              TextField(
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
              const SizedBox(
                height: 30,
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
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
    String name = nameController.text.trim();
    String companyId = companyIdController.text.trim();
    String phoneNo = phoneController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        companyId.isEmpty ||
        phoneNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Please fill all the fields!"),
        ),
      );
    }
    // else if (password != cPassword) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       backgroundColor: Colors.blueGrey,
    //       duration: Duration(seconds: 1),
    //       content: Text("Passwords donot match!"),
    //     ),
    //   );
    // }
    else {
      signUp(
        email: email,
        password: password,
        companyId: companyId,
        name: name,
        phoneNo: phoneNo,
      );
    }
  }

  void signUp({
    required String email,
    required String password,
    required String companyId,
    required String name,
    required String phoneNo,
  }) async {
    UserCredential? credentials;

    try {
      credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: const Duration(seconds: 1),
          content: Text(ex.code.toString()),
        ),
      );
    }

    if (credentials != null) {
      String uid = credentials.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        role: 'user',
        email: email,
        fullName: name,
        isVerified: false,
        profilePic:
            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fone-person&psig=AOvVaw3FoJMfPBL3JBB8qtDn-E-d&ust=1680599721582000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMjOgP2vjf4CFQAAAAAdAAAAABAE",
        phoneNo: countryCode + phoneNo,
        companyId: companyId,
      );
      UserModel.loggedinUser = newUser;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then(
        (value) {
          verifyPhone(newUser.phoneNo);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.secondaryColor,
              duration: Duration(seconds: 1),
              content: Text("New user created!"),
            ),
          );
        },
      );
    }
  }

  void navigate() {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OtpScreen();
        },
      ),
    );
  }

  void verifyPhone(number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        RouteHelper.verificationId = verificationId;
        navigate();
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
