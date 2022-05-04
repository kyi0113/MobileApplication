import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calendarEntry.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPage_ createState() => CalendarPage_();
}

class CalendarPage_ extends State<CalendarPage> {
  List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<String> listOfDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  //List<int> calendarDayIndex ]

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    // MMMM = month only, d = day only, M = month number only, Md = Month and day numbers.
    final DateFormat formatter3 = DateFormat('M');
    final DateFormat formatter4 = DateFormat('y');
    final String currentMonthNumber = formatter3.format(now);
    final String currentYearNumber = formatter4.format(now);

    int currentMonthNumberInt = int.parse(currentMonthNumber);
    //int currentMonthNumberInt = 5; // debug
    int currentYearNumberInt = int.parse(currentYearNumber);

    int _firstDay =
        DateTime.utc(currentYearNumberInt, currentMonthNumberInt).weekday;
    debugPrint('currentMonthNumberInt == $currentMonthNumberInt');
    debugPrint('currentYearNumberInt == $currentYearNumberInt');
    debugPrint('monthDays== == ${monthDays[currentMonthNumberInt - 1]}');

    List<int> calendarDayNumbers = List.filled((6 * 7), 0);
    int previousMonthNumberOfDays = 0;
    if (_firstDay != 7) {
      // WHich means if the month didn't start on a Sunday
      debugPrint("First if statement worked");

      for (int j = 1; j <= monthDays.length; j++) {
        if (currentMonthNumber == j.toString() && currentMonthNumber != "1") {
          previousMonthNumberOfDays = monthDays[j - 2];
        } else if (currentMonthNumber == j.toString()) {
          // Which means currentMontherNumber == 1
          int prevMonth = 12 - ((j - 1) % 12);
          previousMonthNumberOfDays = monthDays[prevMonth - 1];
        }
      }

      int dayCount = 1;
      for (int i = 0; i < (6 * 7); i++) {
        if (_firstDay != 0) {
          calendarDayNumbers[i] = previousMonthNumberOfDays - (_firstDay);
          _firstDay--;
        } else {
          calendarDayNumbers[i] = dayCount;
          if (dayCount + 1 > monthDays[currentMonthNumberInt - 1]) {
            dayCount = 1;
          } else {
            dayCount++;
          }
        }
      }
    } else {
      // does start on a sunday
      for (int j = 1; j <= monthDays.length; j++) {
        if (currentMonthNumber == j.toString() && currentMonthNumber != "1") {
          previousMonthNumberOfDays = monthDays[j - 2];
        } else if (currentMonthNumber == j.toString()) {
          // Which means currentMontherNumber == 1
          int prevMonth = 12 - ((j - 1) % 12);
          previousMonthNumberOfDays = monthDays[prevMonth - 1];
        }
      }

      int dayCount = 1;
      for (int i = 0; i < (6 * 7); i++) {
        calendarDayNumbers[i] = dayCount;
        if (dayCount + 1 > monthDays[currentMonthNumberInt - 1]) {
          dayCount = 1;
        } else {
          dayCount++;
        }
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[0],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[1],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[2],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[3],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[4],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[5],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 8, bottom: 8, right: 8),
                    child: Text(
                      listOfDays[6],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 0; i < 7; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 7; i < 14; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 14; i < 21; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 21; i < 28; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 28; i < 35; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    for (int i = 35; i < 42; i++)
                      dayBlocks(context, calendarDayNumbers[i], i,
                          currentMonthNumberInt),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget dayBlocks(
    BuildContext context, int DayNumber, int index, int currentMonthNumberInt) {
  if (0 <= index && index < 7) {
    if (DayNumber > 10) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width) / 8.0,
        height: ((MediaQuery.of(context).size.height) / 10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
              color: const Color.fromARGB(255, 255, 255, 255)),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
  } else if (28 <= index && index < 42) {
    if (DayNumber < 15) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width) / 8.0,
        height: ((MediaQuery.of(context).size.height) / 10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
              color: const Color.fromARGB(255, 255, 255, 255)),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
  }

  return GestureDetector(
    onTap: () {
      //debugPrint("Hehe, nice job. you got $DayNumber hit and correct!");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CalendarEntry(
                  dayNumber: DayNumber,
                  currentMonthNumberInt: currentMonthNumberInt)));
    },
    child: SizedBox(
      width: (MediaQuery.of(context).size.width) / 8.0,
      height: ((MediaQuery.of(context).size.height) / 10.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
            color: const Color.fromARGB(255, 255, 255, 255)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            DayNumber.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
