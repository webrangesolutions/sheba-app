import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheba_financial/models/reminder_model.dart';
import 'package:sheba_financial/models/user_model.dart';
import 'package:sheba_financial/screens/add_reminder.dart';
import 'package:sheba_financial/utils/color_constants.dart';
import 'package:sheba_financial/utils/route_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../helpers/ui_helper.dart';
import '../models/recipt_model.dart';
import '../widgets/bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _selectedIndex = 0;

  TextEditingController descriptionController = TextEditingController();
  DateTime? finalDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked = TimeOfDay.now();

  // void _onItemTapped(int index) {
  //   if (index == 0) {
  //     Navigator.pushNamed(context, RouteHelper.dashboardRoute);
  //   }
  //   if (index == 1) {
  //     Navigator.pushNamed(context, RouteHelper.scanRoute);
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) {
  //     //       return AddRecipt();
  //     //     },
  //     //   ),
  //     // );
  //   }
  //   if (index == 2) {
  //     Navigator.pushNamed(context, RouteHelper.expensesRoute);
  //   }
  //   if (index == 3) {
  //     Navigator.pushNamed(context, RouteHelper.accountRoute);
  //   }
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  final ImagePicker _imagePicker = ImagePicker();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    String loggedinUser = UserModel.loggedinUser!.uid ?? "";
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("recipts")
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot reciptsSnapshot =
                      snapshot.data as QuerySnapshot;
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.secondaryColor,
                              AppColors.primaryColor
                            ],
                          ),
                        ),
                        height: mediaHeight * 0.4,
                        width: mediaWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: mediaHeight * 0.05),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Welcome back, \n${UserModel.loggedinUser!.fullName}!',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 20),
                                      child: Container(
                                        height: mediaHeight * 0.027,
                                        width: double.infinity,
                                        color: const Color.fromARGB(
                                            255, 34, 213, 102),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Container(
                                      height: mediaHeight * 0.15,
                                      width: mediaWidth * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // const SizedBox(
                                          //   height: 30,
                                          // ),
                                          const Text(
                                            "Total Amount",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "\$",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                getTotal(reciptsSnapshot),
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    fontSize: 40),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Reminder',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                addReminder();
                                print('sent');
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),

                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                          minHeight: 50,
                          maxWidth: mediaWidth,
                          minWidth: mediaWidth,
                        ),
                        // color: Colors.amber,
                        child: StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection("reminders")
                                // .where('isCompleted', isEqualTo: true)
                                .where('uid', isEqualTo: loggedinUser)
                                // .orderBy('dueDate', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              print(loggedinUser);
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  QuerySnapshot reminderSnapshot =
                                      snapshot.data as QuerySnapshot;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: reminderSnapshot.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      ReminderMdel reminderMdel =
                                          ReminderMdel.fromMap(reminderSnapshot
                                              .docs[index]
                                              .data() as Map<String, dynamic>);

                                      return showReminders(reminderMdel);
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else {
                                  return const Center(
                                    child: Text("No Announcements"),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Receipts',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteHelper.scanRoute);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(243, 245, 245, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            243, 245, 245, 1),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Upload Receipt',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 155,
                                child: Builder(builder: (context) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        (reciptsSnapshot.docs.length <= 3)
                                            ? reciptsSnapshot.docs.length
                                            : 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      ReciptModel reciptModel =
                                          ReciptModel.fromMap(
                                              reciptsSnapshot.docs[index].data()
                                                  as Map<String, dynamic>);
                                      return ReciptHomeCard(
                                        reciptModel: reciptModel,
                                      );
                                    },
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      //   child: Container(
                      //     color: Color(Colors.amber.value),
                      //   ),
                      // )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("No Announcements"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      bottomNavigationBar: MyBottomBar(index: _selectedIndex),
    );
  }

  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Choose',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Navigator.pushNamed(context, RouteHelper.scanRoute);
                        final XFile? image = await _imagePicker.pickImage(
                            source: ImageSource.camera);
                        // handle camera option
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/camera.png'),
                          const SizedBox(height: 10),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final XFile? image = await _imagePicker.pickImage(
                            source: ImageSource.gallery);
                        // handle gallery option
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/images/gallery.png'),
                          const SizedBox(height: 10),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getTotal(QuerySnapshot reciptsSnapshot) {
    double total = 0;
    for (var item in reciptsSnapshot.docs) {
      ReciptModel recipt =
          ReciptModel.fromMap(item.data() as Map<String, dynamic>);
      double bill = double.parse(recipt.totalBill.toString().trim());
      total = total + bill;
    }
    return total.toString();
  }

  void datePicker() async {
    var order = await getDate();
    setState(() {
      if (order != null) {
        finalDate = order;
      }
    });
  }

  Future<DateTime?> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    setState(() {
      if (picked != null) {
        _time = picked!;
      }
    });
    dueDate = DateTime(
      finalDate!.year,
      finalDate!.month,
      finalDate!.day,
      _time.hour,
      _time.minute,
    );
    print("Due Date: $dueDate");

    uploadReminder();
  }

  Widget showReminders(ReminderMdel reminderMdel) {
    bool completed =
        (DateTime.parse(reminderMdel.dueDate!).isBefore(DateTime.now()));
    return StatefulBuilder(builder: (context, setReminderState) {
      return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: (completed)
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : Container(),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminderMdel.content ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Due by ${DateFormat.yMMMMd().format(DateTime.parse(reminderMdel.dueDate ?? ''))}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }

  void addReminder() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Add Reminder'),
      content: TextField(
        readOnly: false,
        controller: descriptionController,
        style: const TextStyle(
          color: Colors.grey, // Set the text color to red
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);

              selectTime(context);
              datePicker();
            },
            child: const Text("Ok")),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Future<void> uploadReminder() async {
    UIHelper.showLoadingDialog(context, "Updating Reminder...");
    Uuid uuid = const Uuid();
    ReminderMdel reminderMdel = ReminderMdel(
      id: uuid.v1(),
      content: descriptionController.text.trim(),
      dueDate: dueDate.toString(),
      isCompleted: false,
      uid: UserModel.loggedinUser!.uid,
    );
    await FirebaseFirestore.instance
        .collection("reminders")
        .doc(reminderMdel.id)
        .set(reminderMdel.toMap())
        .then(
      (value) {
        Navigator.pop(context);
      },
    );
    addNotification(reminderMdel);
  }

  void addNotification(ReminderMdel reminderMdel) async {
    try {
      await _notificationService
          .scheduleNotifications(
            id: 1,
            title: reminderMdel.content,
            body: '',
            // time: DateTime.now().add(const Duration(seconds: 2)),
            time: DateTime.parse(reminderMdel.dueDate!),
          )
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.secondaryColor,
                duration: Duration(seconds: 1),
                content: Text("Reminder Added Sucessfully!"),
              ),
            ),
          );
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("An Error Occoured! Please try again"),
        ),
      );
    }
  }
}

class ReciptHomeCard extends StatelessWidget {
  final ReciptModel reciptModel;
  const ReciptHomeCard({
    Key? key,
    required this.reciptModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                reciptModel.createdAt ?? '',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "\$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    reciptModel.totalBill ?? '',
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Text(
                reciptModel.merchant ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
