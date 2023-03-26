import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../utils/route_helper.dart';
import '../widgets/user_info.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, RouteHelper.dashboardRoute);
    }
    if (index == 1) {
      Navigator.pushNamed(context, RouteHelper.scanRoute);
    }
    if (index == 2) {
      Navigator.pushNamed(context, RouteHelper.expensesRoute);
    }
    if (index == 3) {
      Navigator.pushNamed(context, RouteHelper.accountRoute);
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(height: mediaHeight * 0.03),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
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
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                image == null
                    ? Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/user_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                InkResponse(
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      //update UI
                    });
                  },
                  child: Container(
                    height: 50.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Colors.grey,
              height: 20.0,
              thickness: 1.0,
              indent: 50.0,
              endIndent: 50.0,
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            UserInfo('Name', 'Jane Cooper'),
            SizedBox(height: 20),
            UserInfo('Email', 'jane@example.com'),
            SizedBox(height: 20),
            UserInfo('Phone', '+123-456-789-003'),
            const SizedBox(height: 30),
            const Divider(
              color: Colors.grey,
              height: 20.0,
              thickness: 1.0,
              indent: 50.0,
              endIndent: 50.0,
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteHelper.settingsRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteHelper.loginRoute, (Route<dynamic> route) => false);
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
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor: AppColors.secondaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                label: 'Expenses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
