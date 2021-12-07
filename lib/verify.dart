import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/user_page.dart';
import 'user_data.dart';

class VerifyScreen extends StatefulWidget {

  static String id = 'verify';
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    user.sendEmailVerification();

    Future<void> checkEmailVerified() async {
      user = auth.currentUser;
      await user.reload();
      if (user.emailVerified) {
        timer.cancel();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserPage()));
      }
    }

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify your email'),
      ),
      body: Center(
        child: Text('An email has been sent to you. Please Verify.'),
      ),
    );
  }


}