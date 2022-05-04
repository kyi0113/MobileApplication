import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:twitter_login/twitter_login.dart';
import '../authentication/registration.dart';
import '../homepage.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void checkLoginCredentials(BuildContext context2) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      Navigator.push(
          context2, MaterialPageRoute(builder: (context) => const HomePage()));
      ScaffoldMessenger.of(context2).clearSnackBars();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context2).showSnackBar(const SnackBar(
          content: Text(
              "Incorrect Email/Password, Please re-enter login credentials."),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  Future loginFunction(BuildContext context) async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: '0hBeSHfa1mYmNUnzjJxnUVzCT',
      apiSecretKey: 'lvdkNKESrp0Ptz6lemsW1On4li7EPGfQWxcWvzL2KXpZuJfUBX',
      redirectURI: 'myproject://',
    );
    try {
      final authResult = await twitterLogin.loginV2();
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      debugPrint("accessToken = ${authResult.authToken!}");
      debugPrint("accessToken = ${authResult.authTokenSecret!}");
    } on FirebaseAuthException catch (e) {
      debugPrint("error");
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('Assets/logo.JPG'),
                      maxRadius: 60,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Welcome Back!',
                      //style: Theme.of(context).textTheme.headline4),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        color: Color(0xff000912),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
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
                        if (_email!.isNotEmpty) {
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                        if (_password!.isEmpty) {
                          return "Please enter a password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 128, 0),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkLoginCredentials(context);
                      }
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      loginFunction(context);
                    },
                    style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 128, 0),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text("Sign in with Twitter?"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 128, 0),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text("New User?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void oauth() async {}
