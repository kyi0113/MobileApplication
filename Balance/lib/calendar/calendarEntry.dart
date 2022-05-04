import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../financePages/ActionPages/calendarNotePopUp.dart';

class CalendarEntry extends StatefulWidget {
  final int dayNumber;
  final int currentMonthNumberInt;

  CalendarEntry(
      {Key? key, required this.dayNumber, required this.currentMonthNumberInt})
      : super(key: key);

  @override
  CalendarEntry_ createState() => CalendarEntry_(
      dayNumber: dayNumber, currentMonthNumberInt: currentMonthNumberInt);
}

class CalendarEntry_ extends State<CalendarEntry> {
  final int dayNumber;
  final int currentMonthNumberInt;

  CalendarEntry_(
      {required this.dayNumber, required this.currentMonthNumberInt});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMMd');
    final DateFormat formatter2 = DateFormat('d');
    final String format = formatter2.format(now);
    List<String> tabs = ["Category", "Date", "Note", "Money"];

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_left, size: 40)),
            const Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width) / 4.0,
                    height: ((MediaQuery.of(context).size.height) / 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
                          color: Colors.white),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          tabs[0],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width) / 4.0,
                    height: ((MediaQuery.of(context).size.height) / 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
                          color: Colors.white),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          tabs[1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width) / 4.0,
                    height: ((MediaQuery.of(context).size.height) / 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
                          color: Colors.white),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          tabs[2],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width) / 4.0,
                    height: ((MediaQuery.of(context).size.height) / 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: const Color.fromARGB(255, 0, 0, 0)),
                          color: Colors.white),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          tabs[3],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(children: <Widget>[
                buildCollectionEntries(context, formatter, 'bills',
                    'billsNumber', format, dayNumber, currentMonthNumberInt),
                buildCollectionEntries(
                    context,
                    formatter,
                    'emergency',
                    'emergencyNumber',
                    format,
                    dayNumber,
                    currentMonthNumberInt),
                buildCollectionEntries(
                    context,
                    formatter,
                    'personalSpending',
                    'personalSpendingNumber',
                    format,
                    dayNumber,
                    currentMonthNumberInt),
                buildCollectionEntries(context, formatter, 'saving',
                    'savingsNumber', format, dayNumber, currentMonthNumberInt),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget popUpScreen(
    BuildContext context, String note, String id, String collectionString) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          child: Text(note),
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 0, 128, 0),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalendarNotePopUp(
                      id: id, collectionString: collectionString)));
        },
        child: const Text('Edit'),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 0, 128, 0),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

Widget doNothing(BuildContext context) {
  return const SizedBox.shrink();
}

Widget buildCollectionEntries(
    BuildContext context,
    DateFormat formatter,
    String collectionString,
    String collectionNumber,
    String todayDayNumber,
    int dayNumber,
    int currentMonthNumberInt) {
  String dayString = dayNumber.toString();

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(collectionString)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Something went wrong querying conversations");
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: snapshot.data!.size,
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          DocumentSnapshot balanceSnapshot = snapshot.data!.docs[index];
          DateFormat formatter2 = DateFormat('d');
          DateFormat formatter3 = DateFormat('M');
/*
          debugPrint("todayDayNumber == ${todayDayNumber}");
          debugPrint("dayString == $dayString");
          debugPrint("formatter2.format(balanceSnapshot['time'].toDate()) == ${formatter2.format(balanceSnapshot["time"].toDate())}");
          */
          debugPrint(
              "formatter3.format(balanceSnapshot['time'].toDate()) == ${formatter3.format(balanceSnapshot['time'].toDate())}");
          debugPrint("currentMonthNumber == ${currentMonthNumberInt}");
          if (formatter2.format(balanceSnapshot["time"].toDate()).isNotEmpty) {
            // if the time value of that entry is today, then we print it
            if (formatter2.format(balanceSnapshot["time"].toDate()) ==
                    dayString &&
                formatter3.format(balanceSnapshot["time"].toDate()) ==
                    currentMonthNumberInt.toString()) {
              return containerBuilder(context, balanceSnapshot, formatter,
                  collectionNumber, collectionString, dayString);
            } else {
              return doNothing(context);
            }
          } else {
            return doNothing(context);
          }
        },
      );
    },
  );
}

Widget containerBuilder(
    BuildContext context,
    DocumentSnapshot balanceSnapshot,
    DateFormat formatter,
    String collectionNumber,
    String collectionString,
    String dayString) {
  String collectionName;

  if (collectionString == "bills") {
    collectionName = "Bills";
  } else if (collectionString == "emergency") {
    collectionName = "Emerg";
  } else if (collectionString == "personalSpending") {
    collectionName = "Personal";
  } else {
    collectionName = "Saving";
  }

  return Container(
      alignment: FractionalOffset.center,
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(collectionName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  // Need work with intl
                  child: Text(
                      formatter.format(balanceSnapshot["time"].toDate()),
                      style: const TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  // Need work with intl
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => popUpScreen(
                                    context,
                                    balanceSnapshot["note"],
                                    balanceSnapshot.id,
                                    collectionString)));
                      },
                      child: const Text("Note", style: TextStyle(fontSize: 15))),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => popUpScreen(
                                  context,
                                  balanceSnapshot[collectionNumber],
                                  balanceSnapshot.id,
                                  collectionString)));
                    },
                    child: Text("\$${balanceSnapshot[collectionNumber]}",
                        style: const TextStyle(fontSize: 15, color: Colors.green)),
                  ),
                ),
              ]),
        ],
      ));
}
