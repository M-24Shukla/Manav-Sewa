import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/approval_page.dart';
import 'package:manav_seva/approved_booking.dart';
import 'package:manav_seva/book_confirm.dart';
import 'package:manav_seva/booking_history.dart';
import 'package:manav_seva/booking_page.dart';
import 'package:manav_seva/user_page.dart';
import 'package:manav_seva/welcome_page.dart';
import 'home_page.dart';
import 'register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff0D1728),
      ),
      initialRoute: HomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        BookingPage.id: (context) => BookingPage(),
        Register.id: (context) => Register(),
        UserPage.id: (context) => UserPage(),
        HomePage.id: (context) => HomePage(),
        BookingHistory.id: (context) => BookingHistory(),
        ApprovalPage.id: (context) => ApprovalPage(),
        BookConfirm.id: (context) => BookConfirm(),
        ApprovedBooking.id : (context) => ApprovedBooking(),
      },
    );
  }
}
