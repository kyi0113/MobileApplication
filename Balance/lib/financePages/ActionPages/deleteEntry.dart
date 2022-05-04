import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteEntry extends StatefulWidget {
  final String id;
  final BuildContext context;
  final DocumentSnapshot<Object?> totalCategory;
  final String totalCategoryName;
  final String categoryName;
  final int categoryNumber;

  const DeleteEntry(
      {Key? key,
      required this.categoryNumber,
      required this.categoryName,
      required this.id,
      required this.context,
      required this.totalCategory,
      required this.totalCategoryName})
      : super(key: key);

  @override
  DeleteEntry_ createState() => DeleteEntry_(
      categoryNumber: categoryNumber,
      categoryName: categoryName,
      id: id,
      context: context,
      totalCategory: totalCategory,
      totalCategoryName: totalCategoryName);
}

class DeleteEntry_ extends State<DeleteEntry> {
  final int categoryNumber;
  final String categoryName;
  final String totalCategoryName;
  final DocumentSnapshot<Object?> totalCategory;
  final String id;
  final BuildContext context;

  DeleteEntry_(
      {required this.categoryNumber,
      required this.categoryName,
      required this.id,
      required this.context,
      required this.totalCategory,
      required this.totalCategoryName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const SizedBox(
              child: Text("Delete Entry?"),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 128, 0),
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              deleteEntryValue(context, id, totalCategoryName, totalCategory,
                  categoryName, categoryNumber);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 0, 128, 0),
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}

void deleteEntryValue(
    BuildContext context,
    String id,
    String totalCategoryName,
    DocumentSnapshot<Object?> totalCategory,
    String categoryName,
    int categoryNumber) async {
  try {
    await FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'total': FieldValue.increment(categoryNumber),
      totalCategoryName: FieldValue.increment(-(categoryNumber))
    });

    await FirebaseFirestore.instance
        .collection('balance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(categoryName)
        .doc(id)
        .delete();
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.message ?? "Unknown Error!"),
    ));
  }
}
