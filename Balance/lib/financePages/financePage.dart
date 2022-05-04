import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../financePages/ActionPages/totalEntry.dart';
import '../financePages/billing.dart';
import '../financePages/emergency.dart';
import '../financePages/personalSpending.dart';
import 'savings.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  FinancePage_ createState() => FinancePage_();
}

class FinancePage_ extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          top: false,
          child: Scaffold(
            body: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  //padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('balance')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                  "Something went wrong querying conversations");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return ListView.builder(
                                itemCount: snapshot.data!.size,
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot numbers =
                                      snapshot.data!.docs[index];
                                  String total = "";

                                  if (FirebaseAuth.instance.currentUser?.uid ==
                                      numbers.id) {
                                    total = numbers['total'].toString();

                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TotalEntry()));
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  "Total: ",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Text(
                                                  "\$$total",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.green),
                                                ),
                                              )
                                            ]));
                                  } else {
                                    return doNothing(context);
                                  }
                                });
                          }),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SavingsPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width) / 2.0,
                                height: ((MediaQuery.of(context).size.height) /
                                        3.0) +
                                    20.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                      color: Colors.green),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Savings",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BillingPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: (MediaQuery.of(context).size.width) / 2.0,
                              height:
                                  ((MediaQuery.of(context).size.height) / 3.0) +
                                      20.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                                    color: Colors.green),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Bills",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EmergencyPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width) / 2.0,
                            height:
                                ((MediaQuery.of(context).size.height) / 3.0) +
                                    20.0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                  color: Colors.green),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Emergency",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalSpendingPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width) / 2.0,
                            height:
                                ((MediaQuery.of(context).size.height) / 3.0) +
                                    20.0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                  color: Colors.green),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Personal\nSpending",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                )),
          ),
        ));
  }
}

Widget doNothing(BuildContext context) {
  return const SizedBox.shrink();
}
