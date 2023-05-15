import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../widgets/users_detail.dart';

class Users {
  final String imageUrl;
  final String name;
  final String email;
  final bool emailVerified;
  final String lastActivity;
  final String lastProfileUpdate;
  final bool isAdmin;

  Users({
    required this.email,
    required this.emailVerified,
    required this.imageUrl,
    required this.isAdmin,
    required this.lastActivity,
    required this.lastProfileUpdate,
    required this.name,
  });
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Users> _users = [
    Users(
        email: 'andrew@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user3.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'Andrew Johnson'),
    Users(
        email: 'paul@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user1.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'Brain Paul'),
    Users(
        email: 'alex@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user2.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'Alex johns'),
    Users(
        email: 'amy@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user6.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'Amy'),
    Users(
        email: 'ehin@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user5.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'Ehin'),
    Users(
        email: 'james@example.com',
        emailVerified: true,
        imageUrl: 'assets/images/user4.png',
        isAdmin: false,
        lastActivity: '2023-02-03T13:03:39',
        lastProfileUpdate: '2023-02-03T13:03:39',
        name: 'James Kumar'),
  ];
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Users',
          style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: mediaHeight * 0.7,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    height: 70,
                    width: mediaWidth * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(_users[index].imageUrl),
                          radius: 30,
                          // child: Image.asset('assets/images/user1.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _users[index].name,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _users[index].email,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, _users[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                                underline: Container(
                                  height: 0,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                onChanged: ((_) {}),
                                items: []),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
        )
      ],
    )));
  }

  void _showBottomSheet(BuildContext context, Users user) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              UsersDetailWidget(
                title: 'Email',
                value: user.email,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
              ),
              UsersDetailWidget(
                title: 'Email Verified',
                value: user.emailVerified,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
              ),
              UsersDetailWidget(
                title: 'Last Activity',
                value: user.lastActivity,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
              ),
              UsersDetailWidget(
                title: 'Last Profile Update',
                value: user.lastProfileUpdate,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
              ),
              UsersDetailWidget(
                title: 'Admin',
                value: user.isAdmin,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
              ),
            ],
          ),
        );
      },
    );
  }
}
