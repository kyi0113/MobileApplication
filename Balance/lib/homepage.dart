import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fp;
import 'package:intl/intl.dart';
import '../splashScreen.dart';
import 'financePages/financePage.dart';
import '../calendar/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePage_ createState() => HomePage_();
}

// ignore: camel_case_types
class HomePage_ extends State<HomePage> {
  int currentIndex = 0;

  void onTapButton(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMMd');
    final String formatted = formatter.format(now);

    final pages = [const FinancePage(), const CalendarPage()];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(formatted, style: const TextStyle(fontSize: 25)),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                fp.FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SplashScreen();
                }));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
          backgroundColor: Colors.green,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 236, 234, 234),
          onTap: onTapButton,
          currentIndex: currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendar",
            ),
          ],
        ),
      ),
    );
  }
}
