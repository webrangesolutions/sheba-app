import 'package:flutter/material.dart';
import 'package:sheba_financial/utils/color_constants.dart';

class ReceiptScreen extends StatefulWidget {
  final String imagePath;

  ReceiptScreen(this.imagePath);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: AppColors.secondaryColor,
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: mediaWidth * 0.25),
                const Text(
                  'Receipt',
                  style:
                      TextStyle(fontSize: 20, color: AppColors.secondaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
