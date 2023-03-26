import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sheba_financial/utils/color_constants.dart';
import 'package:sheba_financial/utils/route_helper.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  int _counter = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    // code to resend OTP
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: AppColors.secondaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Please Enter OTP Verification',
                style: TextStyle(fontSize: 30, color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                'Code was sent to +254 7085689',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'The code will expire in ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${_counter ~/ 60}:${(_counter % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    activeColor: Colors.grey,
                    selectedColor: Colors.grey,
                    selectedFillColor: Colors.grey,
                    fieldHeight: 50,
                    inactiveColor: Colors.grey,
                    borderWidth: 0,
                    inactiveFillColor: Colors.grey,
                    fieldWidth: 55,
                    activeFillColor: Colors.grey,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Didnt receive an OTP?',
                    style: TextStyle(fontSize: 14),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Resend',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mediaHeight * 0.3,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: mediaWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteHelper.loginRoute,
                          (Route<dynamic> route) => false);
                      Navigator.pushNamed(context, RouteHelper.loginRoute);
                    },
                    child: Text(
                      'Verify and Create Account',
                      style: TextStyle(color: Colors.white),
                    ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
