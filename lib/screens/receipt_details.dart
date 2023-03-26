import 'package:flutter/material.dart';
import 'package:sheba_financial/screens/receipt_view.dart';
import 'package:sheba_financial/utils/color_constants.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  @override
  _ReceiptDetailsScreenState createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  List<String> _categoryItems = [
    'Food',
    'Transport',
    'Entertainment',
    'Meal & Entertainment',
    'Others'
  ];
  List<String> _currencyItems = ['NGN', 'USD', 'XAF', 'EUR', 'GBP'];
  List<String> _paymentItems = [
    'Card',
    'Cash',
    'Bank Transfer',
    'Mobile Money',
    'Others'
  ];
  String _currency = 'NGN';
  String _category = 'Food';
  String _payment = 'Card';

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
              SizedBox(width: mediaWidth * 0.2),
              const Text(
                'Receipt Details',
                style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
              ),
            ],
          ),
        ),
        InkResponse(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceiptScreen('assets/images/receipt_details.png')),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              // image: DecorationImage(
              //   filterQuality: FilterQuality.high,
              //   image: AssetImage('assets/images/receipt_details.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 0, left: 50, right: 50, top: 60),
              child: Image.asset(
                'assets/images/receipt_details.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Merchant',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Chicken Republic',
            style: TextStyle(
              fontSize: 16,
              decorationThickness: 2,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Date',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'July 23,2020',
            style: TextStyle(
              fontSize: 16,
              decorationThickness: 2,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Currency',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                'Total',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: [
                  Flexible(
                      flex: 0,
                      child: DropdownButton(
                        underline: Container(
                          height: 0,
                          width: 0,
                        ),
                        value: _currency,
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16),
                        items: _currencyItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        onChanged: ((value) {
                          setState(() {
                            _currency = value.toString();
                          });
                        }),
                      )),
                ],
              ),
              SizedBox(width: mediaWidth * 0.18),
              Container(
                child: Row(
                  children: [
                    Text(
                      '1,960.76',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ])),
        Row(
          children: const [
            Expanded(
              flex: 4,
              child: Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 16.0,
                endIndent: 0.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 8,
              child: Divider(
                color: Colors.grey,
                thickness: 0.0,
                indent: 0.0,
                endIndent: 16.0,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Description',
            style: TextStyle(fontSize: 14),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Category',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                  width: mediaWidth * 0.9,
                  child: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 16),
                    value: _category,
                    onChanged: ((value) {
                      setState(() {
                        _category = value.toString();
                      });
                    }),
                    items: _categoryItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Method of payment',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                  width: mediaWidth * 0.9,
                  decoration: BoxDecoration(),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(
                      height: 0,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 16),
                    value: _payment,
                    onChanged: ((value) {
                      setState(() {
                        _payment = value.toString();
                      });
                    }),
                    items: _paymentItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Delete Receipt',
              style: TextStyle(color: Colors.red),
            ))
      ]),
    )));
  }
}
