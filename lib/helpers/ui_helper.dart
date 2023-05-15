import 'package:flutter/material.dart';
import 'package:sheba_financial/utils/color_constants.dart';

class UIHelper {
  static void showLoadingDialog(BuildContext context, String title) {
    AlertDialog loadingDialog = AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(title),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loadingDialog;
        });
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: Text(content)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
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
}
