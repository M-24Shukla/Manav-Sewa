import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/user_page.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  static String id = 'user_data';
  String name, mobile;

  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Please Enter Your Details'.toUpperCase()),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            RoundedButton(label: "Upload", colour: Colors.red,
                onPressed: () {
                  user = auth.currentUser;
                  String id = user.uid;
                  _firestore.collection('user-data').add({
                    'uid': user.uid,
                    'name': name,
                    'mobile': mobile,
                    'admin': false
                  });
                  Navigator.pushNamed(context, UserPage.id);
                }
            )
        ],
      ),
      ),
    );
  }
}
