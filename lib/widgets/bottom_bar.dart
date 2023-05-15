import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import '../utils/route_helper.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              (index == 0)
                  ? null
                  : Navigator.pushNamed(context, RouteHelper.dashboardRoute);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  size: 22,
                  color: (index == 0) ? AppColors.secondaryColor : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          (index == 0) ? AppColors.secondaryColor : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              (index == 1)
                  ? null
                  : Navigator.pushNamed(context, RouteHelper.scanRoute);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 22,
                  color: (index == 1) ? AppColors.secondaryColor : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Scan',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          (index == 1) ? AppColors.secondaryColor : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              (index == 2)
                  ? null
                  : Navigator.pushNamed(context, RouteHelper.expensesRoute);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner,
                  size: 22,
                  color: (index == 2) ? AppColors.secondaryColor : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Expenses',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          (index == 2) ? AppColors.secondaryColor : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              (index == 3)
                  ? null
                  : Navigator.pushNamed(context, RouteHelper.accountRoute);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 22,
                  color: (index == 3) ? AppColors.secondaryColor : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          (index == 3) ? AppColors.secondaryColor : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}