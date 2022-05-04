import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/homepage.dart';
import 'calendar.dart';

class CalendarTransitionPage extends StatefulWidget {
  @override
  CalendarTransitionPage_ createState() => CalendarTransitionPage_();
}

class CalendarTransitionPage_ extends State<CalendarTransitionPage> {
  
  @override
  Widget build(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));
    return Container();
  }

}
