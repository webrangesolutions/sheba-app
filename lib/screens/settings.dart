import 'package:flutter/material.dart';
import 'package:sheba_financial/utils/color_constants.dart';
import 'package:sheba_financial/utils/route_helper.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static var cardColor = AppColors.secondaryColor;
  static var iconColor = Colors.white;
  static var textColor = Colors.black;

  @override
  void initState() {
    cardColor = Colors.white;
    iconColor = AppColors.secondaryColor;
    textColor = Colors.black;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: mediaWidth * 0.25),
                  const Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 20, color: AppColors.secondaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.notifications,
                          color: iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ToggleSwitch(
                          animate: true,
                          animationDuration: 300,
                          customWidths: const [35.0, 35.0],
                          iconSize: 20,
                          minHeight: 35,
                          cornerRadius: 20.0,
                          activeBgColors: const [
                            [AppColors.secondaryColor],
                            [Colors.redAccent]
                          ],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          icons: const [
                            Icons.notifications_active,
                            Icons.notifications_off
                          ],
                          // onToggle: (index) {
                          //   print('switched to: $index');
                          // },
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 19,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteHelper.editProfileRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 19,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteHelper.changePasswordRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.lock,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 19,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteHelper.privacyPolicyRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.privacy_tip,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 19,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteHelper.contactUsRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.contact_support,
                            color: iconColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
