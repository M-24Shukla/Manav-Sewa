import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:manav_seva/verify.dart';

import 'constants.dart';

class Register extends StatefulWidget {

  static String id = 'register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email, password, name, mobile, cnf;

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text (
              'User Registration.'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//              name mobile email password  confirm-password
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Name'),
                ),
                SizedBox(height: 10.0,),
                // TextField(
                //   textAlign: TextAlign.center,
                //   keyboardType: TextInputType.name,
                //   onChanged: (value) {
                //     mobile = value;
                //   },
                //   decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Mobile Number'),
                // ),
                // SizedBox(height: 15.0,),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email-id'),
                ),
                SizedBox(height: 10.0,),

                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    cnf = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Retype Your Password'),
                ),
                SizedBox(height: 10.0,),
                RoundedButton(
                    label: "Register",
                    colour: Colors.red,
                    onPressed: () async {
                      print(email);
                      print(password);
                      UserCredential result =  await auth.createUserWithEmailAndPassword(email: email, password: password);
                      User user = result.user;
                      user.updateDisplayName(name);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => VerifyScreen())
                      );
                    }
                )
              ],
            ),
          )
        )
    );
  }
}
