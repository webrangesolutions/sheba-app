import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import '../utils/route_helper.dart';

class Receipt {
  final String date;
  final String image;
  final String title;
  final String amount;
  final String category;

  Receipt(
      {required this.date,
      required this.image,
      required this.title,
      required this.amount,
      required this.category});
}

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String searchText = '';
  int _selectedIndex = 2;

  List<Receipt> receipts = [
    Receipt(
        date: 'July 23',
        amount: "192,98",
        category: 'Meal & Entertaintment',
        image: 'assets/images/receipt.png',
        title: 'Chicken Republic'),
    Receipt(
        date: 'July 23',
        amount: "192,98",
        category: 'Meal & Entertaintment',
        image: 'assets/images/receipt.png',
        title: 'Chicken Republic'),
    Receipt(
        date: 'July 22',
        amount: "192,98",
        category: 'Meal & Entertaintment',
        image: 'assets/images/receipt.png',
        title: 'Chicken Republic'),
    Receipt(
        date: 'July 22',
        amount: "192,98",
        category: 'Meal & Entertaintment',
        image: 'assets/images/receipt.png',
        title: 'Chicken Republic'),
    Receipt(
        date: 'July 22',
        amount: "192,98",
        category: 'Meal & Entertaintment',
        image: 'assets/images/receipt.png',
        title: 'Chicken Republic'),
  ];

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
              child: ListView.builder(
                itemCount: receipts.length,
                itemBuilder: (BuildContext context, int index) {
                  // Check if this is the first receipt with this date
                  bool isFirstWithDate = index == 0 ||
                      receipts[index].date != receipts[index - 1].date;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      if (isFirstWithDate) // Show date header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(),
                            child: Text(
                              receipts[index].date,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteHelper.receiptDetailsRoute);
                        },
                        child: Padding(
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
                                    child: Image.asset(
                                      receipts[index].image,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 35),
                                      Text(receipts[index].title),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            '\$',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Flexible(
                                            child: Text(
                                              receipts[index].amount,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
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
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    receipts[index].category,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
