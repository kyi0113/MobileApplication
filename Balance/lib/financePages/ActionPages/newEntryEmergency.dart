import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewEntryEmergency extends StatefulWidget {
  const NewEntryEmergency({Key? key}) : super(key: key);

  @override
  NewEntryEmergency_ createState() => NewEntryEmergency_();
}

class NewEntryEmergency_ extends State<NewEntryEmergency> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _emergencyNumber = TextEditingController();
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
                      controller: _emergencyNumber,
                      decoration: const InputDecoration(hintText: 'Amount'),
                      validator: (String? _emergencyNumber) {
                        if (_emergencyNumber!.isNotEmpty ||
                            _emergencyNumber == "") {
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
                                    _emergencyNumber.text);
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
    BuildContext context, String _userMessage, String emergencyNumber) async {
  int newTotalEmergencyNumber = int.parse(emergencyNumber);

  try {
    await FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('emergency')
        .doc()
        .set({
      "note": _userMessage,
      "emergencyNumber": emergencyNumber,
      "time": DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection('balance')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
          FirebaseFirestore.instance.collection('balance').doc(doc.id).update({
            "totalEmergency": FieldValue.increment(newTotalEmergencyNumber),
            "total": FieldValue.increment(-(newTotalEmergencyNumber))
          });
        }
      }
    });
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Unknown Error!"),
    ));
  }
}
