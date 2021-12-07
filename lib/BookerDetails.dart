import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookerDetails {

  BookerDetails({this.cd, this.mobile, this.name, this.paid, this.payto, this.menu});

  final String name, mobile, menu, payto;
  final bool paid;
  final DateTime cd;

  String getName() {
    return name;
  }
  String getMobile() => mobile;
  String getMenu() => menu;
  String getPayto() => payto;
  bool getPaid() => paid;
  DateTime getDt() => cd;
}