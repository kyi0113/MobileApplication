import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../homepage.dart';
import 'login.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _password = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Text(
                      'Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                          color: Color(0xff000912)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 8.0, left: 8.0, right: 8.0),
                    child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 75,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                      ),
                      validator: (String? _email) {
                        if (_email != null) {
                          if (_email.contains("@") &&
                              (_email.contains(".com") ||
                                  _email.contains(".edu"))) {
                            return null;
                          } else {
                            return "Please enter a valid email";
                          }
                        } else {
                          return "Please enter an email";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 75,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                      ),
                      validator: (String? _password) {
                        if (_password == null) {
                          return "Please enter a password";
                        }
                        if (_password.length < 6) {
                          return "Please enter at a 7 character password or longer.";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _firstName,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 75,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                      ),
                      validator: (String? _firstName) {
                        if (_firstName == null) {
                          return "Please enter a first name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _lastName,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 75,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 128, 0), width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                      ),
                      validator: (String? _lastName) {
                        if (_lastName == null) {
                          return "Please enter a last name";
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 0, 128, 0),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerUser(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      },
                      child: const Text("Register")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      style: TextButton.styleFrom(
                          primary: const Color.fromARGB(255, 0, 128, 0),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text("Already have an account?")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("A user with that email already exists"),
        ));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Please enter a password with 6 characters or more and a unique symbol."),
        ));
      }
    }

    try {
      await _db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "email": _email.text,
        "firstName": _firstName.text,
        "lastName": _lastName.text,
        "role": "CUSTOMER",
      });

      _db
          .collection("balance")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("saving");

      _db
          .collection("balance")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("personalSpending");

      _db
          .collection("balance")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bills");

      _db
          .collection("balance")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("emergency");

      await _db
          .collection("balance")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "totalSavings": 0,
        "totalBills": 0,
        "totalEmergency": 0,
        "totalPersonalSpending": 0,
        "total": 0,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "Unknown Error!"),
      ));
    }
  }
}
