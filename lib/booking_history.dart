// ADMIN CALENDAR

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/BookerDetails.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hero_dialog_route.dart';

class BookingHistory extends StatefulWidget {
  // const BookingHistort({Key? key}) : super(key: key);
  static String id = "booking_history";
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

Set<Appointment> meetings = new Set<Appointment>();
Set<DateTime> dt_set = new Set<DateTime>();

Map details = new Map<DateTime, BookerDetails>();

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

const String _heroAddTodo = 'add-todo-hero';

class _BookingHistoryState extends State<BookingHistory> {

  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User user;
  String name = "", mobile = "", menu = "", payto = "";
  bool paid = false;
  Future<void> updateSet() async{
    await _firestore.collection('temp').get().then((querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        final email = element.get('email');
        name = element.get('name');
        mobile = element.get('mobile');
        paid = element.get('paid');
        menu = element.get('menu');
        final occasion = element.get('occasion');
        payto = element.get('payment');
        final dt = element.get('date').toDate();
        Color x = Colors.blue;
        details[dt] = BookerDetails(
            cd: dt, name: name, mobile: mobile, paid: paid, payto: payto, menu: menu
        );

        dt_set.add(dt);
        Appointment app = Appointment(
            startTime: dt,
            endTime: dt.add(Duration(seconds: 1)),
            subject: "Slot booked by- $name",
            isAllDay: true,
            color: x,
        );
        setState(() {
          meetings.add(app);
        });
      })
    });

  //  For the second dataset
    await _firestore.collection('approved').get().then((querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        final email = element.get('email');
        name = element.get('name');
        mobile = element.get('mobile');
        paid = true;
        menu = element.get('menu');
        final occasion = element.get('occasion');
        payto = element.get('payment');
        final dt = element.get('date').toDate();
        Color x = Colors.red;
        details[dt] = BookerDetails(
            cd: dt, name: name, mobile: mobile, paid: paid, payto: payto, menu: menu
        );
        dt_set.add(dt);
        Appointment app = Appointment(
          startTime: dt,
          endTime: dt.add(Duration(seconds: 1)),
          subject: "Slot booked by- $name",
          isAllDay: true,
          color: x,
        );
        setState(() {
          meetings.add(app);
        });
      })
    });

  }

  void initState() {
    updateSet();
    super.initState();
  }

  Future<void> _makePhoneCall(String url) async {
    url = "tel:" + url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void pop_up(CalendarTapDetails cd) {
    String msg = 'SLOT IS EMPTY!'.toUpperCase();
    bool flag = false;
    if (dt_set.contains(cd.date)) {
      flag = true;
      msg = "SLOT IS BOOKED";
      if (details[cd.date].getPaid() == true) msg += " AND PAYMENT IS DONE";
      else msg += "BUT PAYMENT IS PENDING";
    }

    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: _heroAddTodo,
            createRectTween: (begin, end) {
              return RectTween(begin: begin, end: end);
            },
            child: Material(
//            color: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
//                  mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      //  Jisne book kiya uska naam -diff
                      //  Jisne book kiya uska phone number and address -diff
                      //  Calling ka option -diff
                      //  Back button  -common
                        Text(
                            msg,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 2,
                          child: Container(color: light,),
                        ),
                        SizedBox(height: 5,),
                        if (flag) ...[
                          Text(
                            // 'Booker',
                              'Slot has been booked by ${details[cd.date].getName()}'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            // 'menu here',
                            'Menu - ${details[cd.date].getMenu()}',
                            style: TextStyle(
                              fontSize: 15
                            )
                          ),
                          SizedBox(height: 10,),
                          Text(
                            // 'hello',
                            'Payment To -  ${details[cd.date].getPayto()}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            height: 2,
                            child: Container(color: light,),
                          ),
                          SizedBox(height: 5,),
                          RoundedButton(
                              label: "Call ${details[cd.date].getMobile()}",
                            // label: "Hello",
                              colour: pink,
                              onPressed: () {
                                // print(details[cd.date].getName());
                                _makePhoneCall(mobile);
                                }
                            )
                            ],
                        RoundedButton(label: "Back", colour: light, onPressed: () {
                          Navigator.pop(context);
                        })
                      ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, settings: null));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: light,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(getAppointments()),
          allowAppointmentResize: true,
          showNavigationArrow: true,
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              monthCellStyle: MonthCellStyle(
                  textStyle: TextStyle(color: Colors.white)
              )
          ),
          todayHighlightColor: pink,
          headerHeight: 45,
          viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              dateTextStyle: TextStyle(fontSize: 14)
            // backgroundColor: Colors.white
          ),
          onTap: (CalendarTapDetails cd) => pop_up(cd),
        )
      ),
    );
  }
}

Set<Appointment> getAppointments(){
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(Set<Appointment> source) {
    List<Appointment> xyz = <Appointment>[];
    if (source != null || source.isNotEmpty)
      source.forEach((element) => xyz.add(element));
    appointments = xyz;
  }
}


class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final CalendarTapDetails cd;
  final String title;
  _AddTodoPopupCard({this.cd, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Booing'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 19,

                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton(
                            label: "Yes",
                            colour: Colors.lightBlueAccent,
                            onPressed: () {

                            },
                            width: 100.0,
                          ),
                          RoundedButton(
                            label: "No",
                            colour: Colors.red,
                            onPressed: () {

                            },
                            width: 100.0,
                          ),
                        ],
                      ),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}