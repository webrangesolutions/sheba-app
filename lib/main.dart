import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheba_financial/router/app_routing.dart';
import 'package:sheba_financial/screens/add_reminder.dart';
import 'package:sheba_financial/utils/route_helper.dart';

import 'helpers/firebase_helper.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await NotificationService().requestIOSPermissions();
  await Firebase.initializeApp();

  // Handle deep links

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool showOnboarding = prefs.getBool('onboarding') ?? true;

  User? currentUser = FirebaseAuth.instance.currentUser;
  // runApp(MyApp(showOnboarding: showOnboarding));
  if (currentUser != null) {
    //logged in
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    } else {
      runApp(MyApp(showOnboarding: showOnboarding));
    }
  } else {
    //not logged in
    runApp(MyApp(showOnboarding: showOnboarding));
  }
}

//Not Logged In
class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({Key? key, required this.showOnboarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      initialRoute:
          (showOnboarding) ? RouteHelper.introRoute : RouteHelper.loginRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

//Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel.loggedinUser = userModel;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      initialRoute: RouteHelper.dashboardRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
