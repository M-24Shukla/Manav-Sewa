// ADMIN PAGE 2

import 'package:flutter/material.dart';
import 'package:manav_seva/approval_page.dart';
import 'package:manav_seva/approved_booking.dart';
import 'package:manav_seva/booking_history.dart';
import 'package:manav_seva/constants.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'booking_page.dart';
const Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class UserPage extends StatelessWidget {

  static String id = 'user_page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Welcome".toUpperCase()),
            backgroundColor: Colors.transparent,
            elevation: 1,
          ),
          body: Center(
            child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 2, child: Container(color: light,)),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: pink,)),
                  SizedBox(height: 30,),
                  SizedBox(height: 2, child: Container(color: light,)),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: pink,)),
                  SizedBox(height: 10,),
                  RoundedButton(
                    width: 250.0,
                      label: "CONFIRM EXISTING SLOT",
                      colour: Color(0xff11cbd7),
                      onPressed: () {Navigator.pushNamed(context, ApprovalPage.id);}
                  ),
                  SizedBox(height: 10,),
                  RoundedButton(
                    width: 250.0,
                      label: "BOOKING HISTORY",
                      colour: Color(0xffc6f1e7),
                      onPressed: () {Navigator.pushNamed(context, BookingHistory.id);}
                  ),
                  SizedBox(height: 10,),
                  RoundedButton(
                    width: 250,
                      label: "APPROVED BOOKINGS",
                      colour: Color(0xfffa4659),
                      onPressed: () {Navigator.pushNamed(context, ApprovedBooking.id);}
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: light,)),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: pink,)),
                  SizedBox(height: 30,),
                  SizedBox(height: 2, child: Container(color: light,)),
                  SizedBox(height: 10,),
                  SizedBox(height: 2, child: Container(color: pink,)),
                ],
              ),
          ),
        )
    );
  }
}
