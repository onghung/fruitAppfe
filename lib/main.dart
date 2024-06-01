import 'package:flutter/material.dart';
import 'package:fruit_app/screens/cart.dart';
import 'package:fruit_app/screens/sign/signin/signin_scr.dart';
import 'package:fruit_app/screens/vegetables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/dashboard.dart';
import 'screens/registration.dart';
import 'screens/welcome.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fruit App",
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      initialRoute: "/",
      routes: {
        "/": (context) => Splash(),
        MyRoutes.welcomeRoute: (context) => WelcomeScreen(),
        MyRoutes.registrationRoute: (context) => RegistrationScreen(),
        MyRoutes.dashboardRoute: (context) => DashboardScreen(),
        MyRoutes.vegetablesRoute: (context) => VegetablesScreen(),
        MyRoutes.cartRoute: (context) => CartScreen(),
      },
    );
  }
}
