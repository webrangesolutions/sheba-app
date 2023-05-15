import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheba_financial/models/recipt_model.dart';
import 'package:sheba_financial/screens/receipt_view.dart';
import 'package:sheba_financial/utils/color_constants.dart';

import '../helpers/ui_helper.dart';
import 'dashboard.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  final ReciptModel recipt;

  const ReceiptDetailsScreen({super.key, required this.recipt});
  @override
  _ReceiptDetailsScreenState createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
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
                      ReceiptScreen(widget.recipt.image ?? '')),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
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
              child: Image.network(
                widget.recipt.image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Merchant',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.recipt.merchant ?? '',
            style: const TextStyle(
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Date',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.recipt.createdAt ?? '',
            style: const TextStyle(
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
              const Text(
                'Currency',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 60,
              ),
              const Text(
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
                    child: Text(
                      widget.recipt.curency ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        decorationThickness: 2,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: mediaWidth * 0.18),
              Container(
                child: Row(
                  children: [
                    Text(
                      widget.recipt.totalBill ?? "",
                      style: const TextStyle(
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Description',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            widget.recipt.description ?? "",
            style: const TextStyle(
              fontSize: 16,
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Category',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.recipt.category ?? "",
            style: const TextStyle(
              fontSize: 16,
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Method of payment',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.recipt.paymentMethod ?? "",
            style: const TextStyle(
              fontSize: 16,
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
        TextButton(
            onPressed: () {
              deleteRecipt(widget.recipt);
            },
            child: const Text(
              'Delete Receipt',
              style: TextStyle(color: Colors.red),
            ))
      ]),
    )));
  }

  Future<void> deleteRecipt(ReciptModel recipt) async {
    UIHelper.showLoadingDialog(context, "Deleting Recipt..");
    await FirebaseFirestore.instance
        .collection("recipts")
        .doc(recipt.reciptId)
        .delete()
        .then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondaryColor,
          duration: Duration(seconds: 1),
          content: Text("Recipt Deleted Sucessfully!"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const DashboardScreen();
        }),
      );
    });
  }
}
