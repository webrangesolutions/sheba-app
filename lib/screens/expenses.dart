import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheba_financial/models/recipt_model.dart';
import 'package:sheba_financial/screens/receipt_details.dart';
import 'package:sheba_financial/widgets/bottom_bar.dart';

import '../utils/color_constants.dart';
import '../utils/route_helper.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});
  @override
  ExpensesScreenState createState() => ExpensesScreenState();
}

class ExpensesScreenState extends State<ExpensesScreen> {
  String searchText = '';
  int _selectedIndex = 2;

  List<ReciptModel> receipts = [];

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

  void handleSearch() {
    // Handle search logic
  }

  void handleRecord() {
    // Handle record logic
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
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
                          setState(() {
                            searchText = value;
                          });
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
                      onPressed: handleRecord,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
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
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: reciptsSnapshot.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            ReciptModel reciptModel = ReciptModel.fromMap(
                                reciptsSnapshot.docs[index].data()
                                    as Map<String, dynamic>);

                            return ReciptsListCard(
                              receipt: reciptModel,
                            );
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
          ],
        ),
        bottomNavigationBar: MyBottomBar(index: _selectedIndex),
      ),
    );
  }
}

class ReciptsListCard extends StatelessWidget {
  const ReciptsListCard({
    Key? key,
    required this.receipt,
    // required this.index, required this.firstDate,
  }) : super(key: key);

  final ReciptModel receipt;
  // final int index;
  // final String firstDate;

  @override
  Widget build(BuildContext context) {
    // String dateCheck = firstDate;
    bool showDate = true;

    // if (index != 0) {
    //   if (receipt.createdAt == dateCheck) {

    //   }
    // }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ReceiptDetailsScreen(
                recipt: receipt,
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(receipt.createdAt ?? ''),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          receipt.image ?? "",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Text(receipt.merchant ?? ''),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              '\$',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Flexible(
                              child: Text(
                                receipt.totalBill ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      receipt.category ?? '',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
