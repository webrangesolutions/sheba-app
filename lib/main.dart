import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_financial/router/app_routing.dart';
import 'package:sheba_financial/utils/route_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      initialRoute: RouteHelper.introRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
