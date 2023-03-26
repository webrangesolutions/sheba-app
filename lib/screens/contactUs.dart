import 'package:flutter/material.dart';
import 'package:sheba_financial/utils/color_constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.secondaryColor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaHeight * 0.04,
          ),
          Text(
            "Welcome to Support and Help",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mediaHeight * 0.04,
          ),
          const Icon(
            Icons.location_on,
            size: 50,
            color: AppColors.secondaryColor,
          ),
          SizedBox(
            height: mediaHeight * 0.015,
          ),
          const Text(
            "990 Airplane Avenue,Hartford,  Zip code  06103,  United States",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mediaHeight * 0.04,
          ),
          const Icon(
            Icons.phone_android,
            size: 50,
            color: AppColors.secondaryColor,
          ),
          SizedBox(
            height: mediaHeight * 0.015,
          ),
          const Text(
            "Phone: 1-800-123-4567",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mediaHeight * 0.04,
          ),
          const Icon(
            Icons.email,
            size: 50,
            color: AppColors.secondaryColor,
          ),
          SizedBox(
            height: mediaHeight * 0.015,
          ),
          const Text(
            "SaimRahdari@gmail.com",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mediaHeight * 0.04,
          ),
          const Icon(
            Icons.watch_later_rounded,
            size: 50,
            color: AppColors.secondaryColor,
          ),
          SizedBox(
            height: mediaHeight * 0.015,
          ),
          const Text(
            "Mon - Fri: 9:00 - 18:00",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ));
  }
}
