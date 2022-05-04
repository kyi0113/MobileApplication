import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewEntrySavings extends StatefulWidget {
  const NewEntrySavings({Key? key}) : super(key: key);

  @override
  NewEntry_ createState() => NewEntry_();
}

class NewEntry_ extends State<NewEntrySavings> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _savingsNumber = TextEditingController();
    final _userMessage = TextEditingController();
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _savingsNumber,
                      decoration: const InputDecoration(hintText: 'Amount'),
                      validator: (String? _savingsNumber) {
                        if (_savingsNumber!.isNotEmpty ||
                            _savingsNumber == "") {
                          return null;
                        } else {
                          return "Please enter a valid amount";
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextField(
                          controller: _userMessage,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Note',
                          ),
                          selectionHeightStyle: BoxHeightStyle.max,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 100, left: 70),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 0, 128, 0),
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                update(context, _userMessage.text,
                                    _savingsNumber.text);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, top: 100),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 0, 128, 0),
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    ));
  }
}

void update(
    BuildContext context, String _userMessage, String savingsNumber) async {
  int newTotalSavingsNumber = int.parse(savingsNumber);

  try {
    await FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('saving')
        .doc()
        .set({
      "note": _userMessage,
      "savingsNumber": savingsNumber,
      "time": DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection('balance')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
          FirebaseFirestore.instance.collection('balance').doc(doc.id).update({
            "totalSavings": FieldValue.increment(newTotalSavingsNumber),
            "total": FieldValue.increment(-(newTotalSavingsNumber))
          });
        }
      });
    });
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Unknown Error!"),
    ));
  }
}
