// ADMIN LOG IN

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/register.dart';
import 'package:manav_seva/user_page.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'constants.dart';

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class WelcomePage extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String email, password;

  final auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MANAV SEWA'),
          backgroundColor: Colors.transparent,
          elevation: 0.3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('images/img.png'),),
                  SizedBox(height: 15,),
                  SizedBox(height: 2, child: Container(color: light,)),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: pink,)),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      TextFormField(
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Email is required';
                          }
                          if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                      ),
                      SizedBox(
                        height: 11.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
                      ),
                      SizedBox(
                          height: 8.0,
                      ),
                      RoundedButton(
                          label: 'Log In',
                          colour: light,
                          onPressed: () async {
                            if(!_formKey.currentState.validate()) {
                              return;
                            }
                            try {
                              await auth.signInWithEmailAndPassword(email: email, password: password).then((authResult) {
                                // print(authResult.user.email);
                                Navigator.pushNamed(context, UserPage.id);
                              });
                            }
                            catch (e) {
                              print("Mayank  \n\n\n\n $e");
                            }
                          }
                          ),

                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.red,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //     child: Icon(
        //       CupertinoIcons.person_add_solid,
        //     )
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, Register.id);
        //   },
        // ),
      ),
    );
  }
}
