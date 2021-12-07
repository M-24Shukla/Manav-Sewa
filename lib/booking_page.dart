// USER CALENDAR PAGE

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/book_confirm.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'constants.dart';
import 'hero_dialog_route.dart';

class BookingPage extends StatefulWidget {

  static String id = 'booking_page';

  @override
  _BookingPageState createState() => _BookingPageState();
}
Set<Appointment> meetings = new Set<Appointment>();
Set<DateTime> dt_set = new Set<DateTime>();

const String _heroAddTodo = 'add-todo-hero';

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class _BookingPageState extends State<BookingPage> {



  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User user;

  Future<void> updateSet() async{
    await _firestore.collection('temp').get().then((querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        final dt = element.get('date').toDate();
        final before = DateTime.now().subtract(Duration(days: 1));
        final after = DateTime.now().add(Duration(days: 90));
        if (dt.compareTo(before) == -1 || dt.compareTo(after) == 1) {
          // do nothing
        }
        else {
          dt_set.add(dt);
          Appointment app = Appointment(
              startTime: dt,
              endTime: dt.add(Duration(seconds: 1)),
              subject: 'Slot already booked!',
              isAllDay: true,
              color: Colors.greenAccent);
          setState(() {
            meetings.add(app);
          });
        }
      })
    });
    await _firestore.collection('approved').get().then((querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        final dt = element.get('date').toDate();
        final before = DateTime.now().subtract(Duration(days: 1));
        final after = DateTime.now().add(Duration(days: 90));
        if (dt.compareTo(before) == -1 || dt.compareTo(after) == 1) {
          // do nothing
        }
        else {
          dt_set.add(dt);
          Appointment app = Appointment(
              startTime: dt,
              endTime: dt.add(Duration(seconds: 1)),
              subject: 'Slot already booked!',
              isAllDay: true,
              color: Colors.red);
          setState(() {
            meetings.add(app);
          });
        }
      })
    });
  }

  void addToSet(CalendarTapDetails calendarTapDetails, String name) {
    dt_set.add(calendarTapDetails.date);
    Appointment app = Appointment(
      startTime: calendarTapDetails.date,
      endTime: calendarTapDetails.date.add(Duration(hours: 23)),
      subject: 'Slot booked.',
      isAllDay: true,
      color: Colors.greenAccent,

    );
      setState(() {
        meetings.add(app);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    updateSet();
    print("Mayank Shukla asks to print ${meetings.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    void go(CalendarTapDetails cd) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BookConfirm(cd: cd,)));
      // Navigator.pop(context);
      // initState();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: dark,
        body: SfCalendar(

          view: CalendarView.month,
          dataSource: MeetingDataSource(getAppointments()),
          onTap: go,
          monthViewSettings: MonthViewSettings(
            showAgenda: true,
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(color: Colors.white)
            )
          ),
          allowAppointmentResize: true,
          minDate: DateTime.now(),
          blackoutDates: dt_set.toList(),
          showNavigationArrow: true,
          headerHeight: 45,
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            dateTextStyle: TextStyle(fontSize: 14)
            // backgroundColor: Colors.white
          ),
          blackoutDatesTextStyle: TextStyle(
            // fontSize: 10
            color: Colors.white30
          ),
        ),
      ),
    );
  }

  Row yesNoRow(CalendarTapDetails cd, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButton(
          label: "Yes",
          colour: Colors.lightBlueAccent,
          onPressed: () {
            user = auth.currentUser;
            final String booker = user.displayName;
            addToSet(cd, booker);
          },
          width: 100.0,
        ),
        RoundedButton(
          label: "No",
          colour: Colors.red,
          onPressed: () {
            Navigator.pop(context);
          },
          width: 100.0,
        )
      ],
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
//            color: Colors.red,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
//                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Do you want to make a booking?'.toUpperCase(),
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