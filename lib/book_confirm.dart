// PAGE FOR USERS TO CONFIRM THEIR BOOKING

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manav_seva/utilities/rounded_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class BookConfirm extends StatefulWidget {

  static String id = 'book_confirm';

  BookConfirm({this.cd});

  final CalendarTapDetails cd;

  @override
  _BookConfirmState createState() => _BookConfirmState();
}
const Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class _BookConfirmState extends State<BookConfirm> {

  String name = "", mobile = "", email = "";

  String menudd = 'चावल एवं सब्जी - 3500/-', occdd = 'जन्मदिन', paydd = 'CAआनंद अग्रवाल - तिलकनगर चाटापारा बिलासपुर - 9425219442';
  List<String> occasion = ['जन्मदिन', 'शादी की सालगिरह', 'सवामणि', 'पुण्यतिथि/बरसी', 'अन्य'];
  List<String> menu = ['चावल एवं सब्जी - 3500/-', 'चावल,सब्जी एवं एक मीठा - 9000/-', 'चावल,सब्जी एवं पूरी 11000/-', 'चावल,सब्जी, पूरी एवं एक मीठा - 15000/-', 'चावल, सब्जी, पूरी एवं दो मीठा - 21000/- '];

  List<String> payto = ['CAआनंद अग्रवाल - तिलकनगर चाटापारा बिलासपुर - 9425219442', 'CA सुरेंद्र अग्रवाल - श्रीकांत वर्मा मार्ग  बिलासपुर - 9425220251 ', 'दीपक मोदी - पी 2, संजय अपार्टमेंट व्यापार विहार रोड बिलासपुर - 9826517676', 'अजय अग्रवाल -Mohra Building  जूनिलाईन बिलासपुर', 'विष्णु मुरारका - श्री शारदा इटरप्राइएजेज गोलबाजार बिलासपुर -  9893021647', 'CA सचेन्द्र जैन - जैन प्लाजा, CMD चौक बिलासपुर - 9644530249', 'CA प्रिंस मल्होत्रा - लिंक रोड बिलासपुर - 8109800048', 'गणेश मोदी -मोदी प्रॉविजन गायत्री मंदिर रोड़,विनोबा नगर बिलासपुर - 9827168864', 'संदीप अग्रवाल -श्री कामर्शियल, कुबेर प्लाजा मगरपारा बिलासपुर - 9827924200', 'बजरंग मित्तल -शिला पार्क, राजकिशोर नगर बिलासपुर -  9179533475', 'CA अंशुमन जाजोदिया - मध्यनगरी चौक बिलासपुर - 9827107281', 'अनिल अग्रवाल (गुड़ाखु वाले)- बिलासपुर - 9826528900', 'भूपेंद्र बंसल - अशोक विहार कालोनी पंडरी रायपुर - 9340678243'];


  String user_template = "template_tlfit6b", admin_template = "template_17bybqf";

  Future sendEmail({String name2, String email2, String mobile2, String menu2, String date2, String occasion2, String payment2, String template,  String subj}) async {
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
          'subj' : subj,
          'to_name' : name2,
          'mob' : mobile2,
          'to_email': email2,
          'date' : date2,
          'menu' : menu2,
          'occasion': occasion2,
          'payto': payment2
        }
      })
    );

    print(response.body);
  }
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    String day = widget.cd.date.day.toString();
    if (day.compareTo("9") >= 0) day = "0" + day;
    List<String> months= ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];
    day += "/${months[widget.cd.date.month-1]}/${widget.cd.date.year.toString()}";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(day, style: TextStyle(decorationStyle: TextDecorationStyle.dashed),),
          backgroundColor: Colors.transparent,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is required!';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Name'),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Mobile number is required';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      mobile = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Mobile Number'),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (String value) {
                      if(value.isEmpty){
                        return 'Email is required';
                      }

                      if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
                        return 'Enter a valid email address';
                      }

                      // validator has to return something :)
                      return null;

                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email-id'),
                  ),
                  SizedBox(height: 10.0,),
                  dropDownMenu(menu),
                  SizedBox(height: 10.0,),
                  dropDownOccasion(occasion),
                  SizedBox(height: 10.0,),

                  dropDownPay(payto),
                  SizedBox(height: 25.0,),
                  RoundedButton(
                      label: "Make Booking!",
                      colour: pink,
                      onPressed: ()  {
                        if(!_formKey.currentState.validate()) {
                          return;
                        }
                        // return;
                        sendEmail(name2: name, mobile2: mobile, email2: email, menu2: menudd, date2: day, occasion2: occdd, payment2: paydd, template: user_template, subj: "Sewa meal has been requested.");

                        sendEmail(name2: name, mobile2: mobile, email2: "manavsewabsp@gmail.com", menu2: menudd, date2: day, occasion2: occdd, payment2: paydd, template: admin_template, subj: "New Meal Request.");

                        print("Menu: $menudd\nOccasion: $occdd\nPayment To: $paydd");
                        Map<String, dynamic> data = {
                          'name' : name,
                          'email': email,
                          'date': widget.cd.date,
                          'mobile': mobile,
                          'menu': menudd,
                          'payment': paydd,
                          'occasion': occdd,
                          'paid': false,
                        };
                        FirebaseFirestore.instance.collection('temp').add(data);
                        Navigator.pop(context);
                      }
                  ),
                  SizedBox(height: 5.0,),
                  RoundedButton(
                      label: "Cancel",
                      colour: Colors.blueGrey,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Container dropDownMenu(List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        border: Border.all(color: light, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Menu"),
          Container(
            width: 200.0,
            child: DropdownButton<String>(
              isExpanded: true,
              borderRadius: BorderRadius.circular(10.0),
              menuMaxHeight: 600.0,
              itemHeight: 50,
              value: menudd,
              icon: Icon(Icons.keyboard_arrow_down),
              items:items.map((String items) {
                return DropdownMenuItem(
                    value: items,
                    child: Text(items)
                );
              }
              ).toList(),
              onChanged: (String newValue){
                setState(() {
                  menudd = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }
  Container dropDownPay(List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          border: Border.all(color: light, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Payment To: "),
          Container(
            width: 200.0,
            child: DropdownButton(
              isExpanded: true,
              borderRadius: BorderRadius.circular(10.0),
              menuMaxHeight: 700.0,
              itemHeight: 70,
              value: paydd,
              icon: Icon(Icons.keyboard_arrow_down),
              items:items.map((String items) {
                return DropdownMenuItem<String>(
                    value: items,
                    child: Text(items)
                );
              }
              ).toList(),
              onChanged: (String newValue){
                setState(() {
                  paydd = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }
  Container dropDownOccasion(List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          border: Border.all(color: light, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Occasion"),
          Container(
            width: 130.0,
            child: DropdownButton<String>(
              value: occdd,
              icon: Icon(Icons.keyboard_arrow_down),
              items:items.map((String items) {
                return DropdownMenuItem(
                    value: items,
                    child: Text(items)
                );
              }
              ).toList(),
              onChanged: (String newValue){
                setState(() {
                  occdd = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
