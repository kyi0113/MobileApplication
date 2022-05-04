import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarNotePopUp extends StatefulWidget {
  final String id;
  final String collectionString;

  const CalendarNotePopUp(
      {Key? key, required this.id, required this.collectionString})
      : super(key: key);

  @override
  CalendarNotePopUp_ createState() =>
      CalendarNotePopUp_(id: id, collectionString: collectionString);
}

class CalendarNotePopUp_ extends State<CalendarNotePopUp> {
  final String id;
  final String collectionString;
  CalendarNotePopUp_({required this.id, required this.collectionString});
  final _userMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: TextFormField(
              controller: _userMessage,
              decoration: const InputDecoration(
                labelText: 'Enter the note...',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              ),
              validator: (String? _userMessage) {
                if (_userMessage == null) {
                  return "Enter the note...";
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 0, 128, 0),
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            update(context, _userMessage.text, id, collectionString);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
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
}

void update(BuildContext context, String _userMessage, String id,
    String collectionString) async {
  try {
    await FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(collectionString)
        .doc(id)
        .update({"note": _userMessage});
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Unknown Error!"),
    ));
  }
}
