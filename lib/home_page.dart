// FIRST PAGE OF THE APP

import 'package:flutter/material.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:manav_seva/welcome_page.dart';

import 'booking_page.dart';
//
// Navigator.pushNamed(context, WelcomePage.id);

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class HomePage extends StatelessWidget {

  static String id = 'home_page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0D1728),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: AssetImage('images/manav.jpg'),
                ),
                Image(
                  image: AssetImage('images/footer.jpg'),
                ),
                SizedBox(height : 80),
                Column(
                  children: [
                    SizedBox(height: 15,),
                    SizedBox(height: 2, child: Container(color: light,)),
                    SizedBox(height: 10,),
                    SizedBox(height: 2, child: Container(color: pink,)),
                    SizedBox(height: 30,),
                    RoundedButton(
                        label: "BOOK A SEWA",
                        width: 250.0,
                        colour: Color(0xff11cbd7),
                        onPressed: () {Navigator.pushNamed(context, BookingPage.id);}
                    ),
                    SizedBox(height : 20),
                    RoundedButton(
                        label: "ADMIN",
                        width: 250.0,
                        colour: Color(0xfffa4659),
                        onPressed: () {Navigator.pushNamed(context, WelcomePage.id);}
                    ),
                    SizedBox(height: 30,),
                    SizedBox(height: 2, child: Container(color: light,)),
                    SizedBox(height: 10,),
                    SizedBox(height: 2, child: Container(color: pink,)),
                    SizedBox(height: 50),
                    Text(
                      'मानव सेवा मंगला चौक के पास बस स्टैंड रोड, बिलासपुर 495001',
                      style: TextStyle(color: light),
                    )
                  ],
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}
