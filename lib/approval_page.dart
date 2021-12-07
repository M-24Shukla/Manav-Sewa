// PAGE FOR APPROVING OR DISCARDING

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/constants.dart';
import 'package:manav_seva/utilities/reusable_card.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'hero_dialog_route.dart';

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class ApprovalPage extends StatefulWidget {
  static String id = 'approval_page';

  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {

  List<String> menu = ['चावल एवं सब्जी - 3500/-', 'चावल,सब्जी एवं एक मीठा - 9000/-', 'चावल,सब्जी एवं पूरी 11000/-', 'चावल,सब्जी, पूरी एवं एक मीठा - 15000/-', 'चावल, सब्जी, पूरी एवं दो मीठा - 21000/- '];


  Map<String, String> payto = {
    'CAआनंद अग्रवाल - तिलकनगर चाटापारा बिलासपुर - 9425219442': '9425219442',
    'CA सुरेंद्र अग्रवाल - श्रीकांत वर्मा मार्ग  बिलासपुर - 9425220251': '9425220251',
    'दीपक मोदी - पी 2, संजय अपार्टमेंट व्यापार विहार रोड बिलासपुर - 9826517676': '9826517676',
    'अजय अग्रवाल -Mohra Building  जूनिलाईन बिलासपुर' : 'ajay',
    'विष्णु मुरारका - श्री शारदा इटरप्राइएजेज गोलबाजार बिलासपुर -  9893021647': '9893021647',
    'CA सचेन्द्र जैन - जैन प्लाजा, CMD चौक बिलासपुर - 9644530249': '9644530249',
    'CA प्रिंस मल्होत्रा - लिंक रोड बिलासपुर - 8109800048': '8109800048',
    'गणेश मोदी -मोदी प्रॉविजन गायत्री मंदिर रोड़,विनोबा नगर बिलासपुर - 9827168864': '9827168864',
    'संदीप अग्रवाल -श्री कामर्शियल, कुबेर प्लाजा मगरपारा बिलासपुर - 9827924200': '9827924200',
    'बजरंग मित्तल -शिला पार्क, राजकिशोर नगर बिलासपुर -  9179533475': '9179533475',
    'CA अंशुमन जाजोदिया - मध्यनगरी चौक बिलासपुर - 9827107281': '9827107281',
    'अनिल अग्रवाल (गुड़ाखु वाले)- बिलासपुर - 9826528900': '9826528900',
    'भूपेंद्र बंसल - अशोक विहार कालोनी पंडरी रायपुर - 9340678243': '9340678243'
  };

  final _firestore = FirebaseFirestore.instance;
  String user_template = "template_tlfit6b", admin_template = "template_17bybqf";
  Future sendEmail({String name2, String email2, String mobile2, String menu2, String date2, String occasion2, String payment2, String template, String subj, String made}) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': 'service_efin6sf',
          'template_id': template ,
          'user_id': 'user_cMDMGW51w8pE4n1tV70rc',
          'template_params' : {
            'to_name' : name2,
            'subj' : subj,
            'mob' : mobile2,
            'to_email': email2,
            'date' : date2,
            'menu' : menu2,
            'occasion': occasion2,
            'payto': payment2,
            'made': made
          }
        })
    );

    print(response.body);
  }

  Future<void> _makePhoneCall(String url) async {
    url = "tel:" + url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //name2: name,email2: email, mobile2: mobile,
  //                                     menu2: menu, date2: day, payment2: payment

  void func(var details, String name, String email, String mobile, String menu, String day, String payment, String occasion, DateTime date) {
    String confirmation = "";
    final controller = TextEditingController();
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
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "DO YOU WANT TO CONFIRM THIS BOOKING?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 15),
                      TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          confirmation = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Mobile Number'),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton(
                            width: 100,
                              label: "Yes",
                              colour: pink,
                              onPressed: () async{
                              bool okay = payto[payment] == confirmation;
                                if (!okay) {
                                  controller.clear();
                                  return;
                                }
                                sendEmail(
                                    name2: name,email2: email, mobile2: mobile,
                                    menu2: menu, date2: day, payment2: payment, template: user_template,
                                    subj: "Your booking has been confirmed!", made: "confirmed!"
                                );
                                // admin
                                sendEmail(
                                    name2: name,email2: email, mobile2: mobile,
                                    menu2: menu, date2: day, payment2: payment, template: admin_template,
                                    subj: "Booking on $day has been confirmed!", made: "confirmed"
                                );
                              Map<String, dynamic> data2 = {
                                'name': name,
                                'mobile': mobile,
                                'email': email,
                                'payment': payment,
                                'occasion': occasion,
                                'menu': menu,
                                'date': date,
                              };
                              // await _firestore.collection('temp').add(data1);
                              await _firestore.collection('approved').add(data2);
                              await _firestore.collection('temp').doc(details.id).delete();
                                print(details.id);
                                Navigator.pop(context);
                              }
                          ),
                          RoundedButton(
                            width: 100,
                              label: "No",
                              colour: light,
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      ),
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

  void func2(var details, String name, String email, String mobile, String menu, String day, String payment) {
    final controller = TextEditingController();
    String confirmation = "";
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
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "DO YOU WANT TO DISCARD THIS BOOKING?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height : 15),
                      TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          confirmation = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Mobile Number'),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton(
                            width: 100,
                              label: "Yes",
                              colour: pink,
                              onPressed: () async{

                              bool okay = payto[payment] == confirmation;
                              if (!okay) {
                                controller.clear();
                                return;
                              }
                                sendEmail(
                                    name2: name,email2: email, mobile2: mobile,
                                    menu2: menu, date2: day, payment2: payment, template: user_template,
                                    subj: "Your booking has been cancelled!", made: "cancelled!"
                                );
                                // admin
                                sendEmail(
                                    name2: name,email2: email, mobile2: mobile,
                                    menu2: menu, date2: day, payment2: payment, template: admin_template,
                                    subj: "Booking on $day has been cancelled!", made: "cancelled"
                                );
                                //sdk gphone x86 arm
                                await _firestore.collection('temp').doc(details.id).delete();
                                print(details.id);
                                Navigator.pop(context);
                              }
                          ),
                          RoundedButton(
                            width: 100,
                              label: "No",
                              colour: light,
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      ),
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
            title: Text('Booking Confirmation'.toUpperCase()),
            backgroundColor: Colors.transparent,
            foregroundColor: light,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: StreamBuilder(
              stream: _firestore.collection('temp').orderBy('date').snapshots(),
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
                  String mobile = details['mobile'], email = details['email'], payment = details['payment'];
                  String menu = details['menu'], occasion = details['occasion'];
                  String name = details['name'];
                  DateTime date = details['date'].toDate();
                  if (date.isBefore(DateTime.now())) {
                    continue;
                  }
                  String day = date.day.toString();
                  if (day.compareTo("9") >= 0) day = "0" + day;
                  List<String> months= ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];
                  day += "/${months[date.month-1]}/${date.year.toString()}";
                //  Aur data add karo
                  Widget x = Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ReusableCard(
                      colour: pink,
                      cardChild: Column(
                        children: [
                          SizedBox(height: 7,),
                          Text(
                            name,
                            style: TextStyle(color: light, fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(day, style: TextStyle(color: light),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 2.0,
                              child: Container(color: Colors.black54,),
                            ),
                          ),
                          Text(
                              details['menu'],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: light),
                          ),
                          SizedBox(height: 7,),
                        ],
                      ),
                  )
                  );
                  Widget y = ReusableCard(
                      colour: pink,
                      cardChild: Row(
                        children: [
                          Expanded(
                            child: x,
                            flex: 3,
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async{
                                      String day = date.day.toString();
                                      if (day.compareTo("9") >= 0) day = "0" + day;
                                      List<String> months= ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];
                                      day += "/${months[date.month-1]}/${date.year.toString()}";
                                      //User
                                      func(details, name, email, mobile, menu, day, payment, occasion, date);
                                    },
                                    icon: Icon(Icons.add_task_rounded, color: light,),
                                ),
                                IconButton(
                                    onPressed: () async{
                                      func2(details, name, email, mobile, menu, day, payment);
                                    },
                                    icon: Icon(Icons.delete, color: light)
                                ),
                                IconButton(
                                  onPressed: () {
                                    _makePhoneCall(mobile);
                                  },
                                  icon: Icon(Icons.call, color: light)
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                  );
                  detail.add(y);
                  detail.add(SizedBox(height: 20));
                }

                return ListView(children: detail,);
              },
            ),
          )
        )
    );
  }

  void approveData(String name, String email, String mobile, String payment, String occasion, String menu, DateTime date, var details) async{
    Map<String, dynamic> data1 = {
      'paid': true,
      'name': name,
      'mobile': mobile,
      'email': email,
      'payment': payment,
      'occasion': occasion,
      'menu': menu,
      'date': date,
    };

  }
}
String _heroAddTodo = "Hello";

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}

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