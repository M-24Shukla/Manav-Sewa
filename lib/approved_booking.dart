import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/utilities/reusable_card.dart';

class ApprovedBooking extends StatefulWidget {
  static String id = "approved_booking";

  @override
  _ApprovedBookingState createState() => _ApprovedBookingState();
}

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class _ApprovedBookingState extends State<ApprovedBooking> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('15 days booking'.toUpperCase()),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: StreamBuilder(
                stream: _firestore.collection('approved').orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Column(
                      children: <Widget>[
                        Text('Loading...'),
                        CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)
                      ],
                    ));
                  }
                  final information = snapshot.data.docs;
                  List<Widget> detail =[];
                  for (var details in information) {
                    String name = details['name'];
                    DateTime date = details['date'].toDate();
                    if (date.isBefore(DateTime.now())) {
                      continue;
                    }
                    if (date.isAfter(DateTime.now().add(Duration(days: 15)))) {
                      continue;
                    }
                    String day = date.day.toString();
                    if (day.compareTo("9") >= 0) day = "0" + day;
                    List<String> months= ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];
                    day += "/${months[date.month-1]}/${date.year.toString()}";
                    //  Aur data add karo
                    Widget x = ReusableCard(
                      colour: pink,
                      cardChild: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: dark),
                          ),
                          SizedBox(height: 5),
                          Text(
                              day,
                              style: TextStyle(color: dark),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 2.0,
                              child: Container(color: light,),
                            ),
                          ),
                          Text(
                            details['menu'],
                            style: TextStyle(color: dark, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    );

                    detail.add(x);
                    detail.add(SizedBox(height: 20));
                  }

                  return ListView(children: detail,);
                },
              ),
            )
        )
    );
  }
}
