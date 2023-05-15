import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheba_financial/utils/color_constants.dart';
import 'package:sheba_financial/widgets/bottom_bar.dart';

import '../models/user_model.dart';
import '../utils/route_helper.dart';
import '../widgets/user_info.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 3;
  UserModel userModel = UserModel.loggedinUser!;

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: mediaHeight * 0.03),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Center(
                  child: Text(
                    'Accounts',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaHeight * 0.05),
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userModel.profilePic ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.grey,
                height: 20.0,
                thickness: 1.0,
                indent: 50.0,
                endIndent: 50.0,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              UserInfo('Name', '${userModel.fullName}'),
              const SizedBox(height: 20),
              UserInfo('Email', '${userModel.email}'),
              const SizedBox(height: 20),
              UserInfo('Phone', '${userModel.phoneNo}'),
              const SizedBox(height: 20),
              UserInfo('Company ID', '${userModel.companyId}'),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.grey,
                height: 20.0,
                thickness: 1.0,
                indent: 50.0,
                endIndent: 50.0,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteHelper.settingsRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteHelper.loginRoute,
                        (Route<dynamic> route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomBar(index: _selectedIndex),
      ),
    );
  }
}
