import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../financePages/ActionPages/deleteEntry.dart';
import '../financePages/ActionPages/notePopUp.dart';
import '../financePages/ActionPages/newEntrySavings.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  SavingsPage_ createState() => SavingsPage_();
}

class SavingsPage_ extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMMd');
    final DateFormat formatter3 = DateFormat('M');
    final DateFormat formatter4 = DateFormat('y');
    final String currentMonthNumber = formatter3.format(now);
    int currentMonthNumberInt = int.parse(currentMonthNumber);
    final String currentYearNumber = formatter4.format(now);
    int currentYearNumberInt = int.parse(currentYearNumber);

    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_left, size: 40)),
            ]),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('balance')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        "Something went wrong querying conversations");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot numbers = snapshot.data!.docs[index];
                        String totalSavingsVar = "uhh";

                        if (FirebaseAuth.instance.currentUser!.uid ==
                            numbers.id) {
                          totalSavingsVar = numbers['totalSavings'].toString();

                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Total Savings: \$$totalSavingsVar",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                )
                              ]);
                        } else {
                          return doNothing(context);
                        }
                      });
                }),
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('balance')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('saving')
                    .orderBy('time', descending: false)
                    .limit(30)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        "Something went wrong querying conversations");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot numbers = snapshot.data!.docs[index];

                      if (currentMonthNumberInt ==
                              int.parse(formatter3
                                  .format(numbers["time"].toDate())) &&
                          currentYearNumberInt ==
                              int.parse(formatter4
                                  .format(numbers["time"].toDate()))) {
                        return Container(
                            alignment: FractionalOffset.center,
                            padding: const EdgeInsets.only(left: 10),
                            //margin: EdgeInsets.only(left: 70, top:0, right: 0, bottom:0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                        alignment: Alignment.center,
                                        icon:
                                            const Icon(Icons.delete, size: 12),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DeleteEntry(
                                                      context: context,
                                                      id: numbers.id,
                                                      categoryName: 'savings',
                                                      totalCategory: numbers,
                                                      totalCategoryName:
                                                          'totalSavings',
                                                      categoryNumber: int.parse(
                                                          numbers[
                                                              'savingsNumber']))));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40),
                                        // Need work with intl
                                        child: Text(
                                            formatter.format(
                                                numbers["time"].toDate()),
                                            style:
                                                const TextStyle(fontSize: 15)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        // Need work with intl
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          popUpScreen(
                                                              context,
                                                              numbers["note"],
                                                              numbers.id)));
                                            },
                                            child: const Text("Note",
                                                style:
                                                    TextStyle(fontSize: 15))),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        child: Text(
                                            "\$${numbers["savingsNumber"]}",
                                            style:
                                                const TextStyle(fontSize: 15)),
                                      ),
                                    ]),
                              ],
                            ));
                      } else {
                        return doNothing(context);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 128, 0),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewEntrySavings()));
                  },
                  child: const Text("New Entry"),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget popUpScreen(BuildContext context, String note, String id) {
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
                  builder: (context) => NotePopUp(id: id, category: "saving")));
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
