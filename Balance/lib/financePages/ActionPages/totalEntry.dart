import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TotalEntry extends StatefulWidget {
  const TotalEntry({Key? key}) : super(key: key);

  @override
  TotalEntry_ createState() => TotalEntry_();
}

class TotalEntry_ extends State<TotalEntry> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _totalNumber = TextEditingController();
    final _userMessage = TextEditingController();

    return MaterialApp(
      home: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _totalNumber,
                      decoration: const InputDecoration(
                        hintText: 'Enter Total Amount in Bank Account',
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 75,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                      ),
                      validator: (String? _totalNumber) {
                        if (_totalNumber!.isNotEmpty || _totalNumber == "") {
                          return null;
                        } else {
                          return "Please enter a valid amount";
                        }
                      },
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
                                    _totalNumber.text);
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
    );
  }
}

void update(
    BuildContext context, String _userMessage, String totalNumber) async {
  int newTotalTotalNumber = int.parse(totalNumber);

  try {
    await FirebaseFirestore.instance
        .collection('balance')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
          FirebaseFirestore.instance
              .collection('balance')
              .doc(doc.id)
              .update({"total": FieldValue.increment((newTotalTotalNumber))});
        }
      }
    });
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Unknown Error!"),
    ));
  }
}
