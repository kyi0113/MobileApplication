import 'package:flutter/material.dart';
import 'dart:async';
import 'authentication/login.dart';
import 'authentication/registration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

@override
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goHome();
  }

  goHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('Assets/logo.JPG', alignment: Alignment.center, scale: 1),
          const Text("Loading...",
              textScaleFactor: 1, style: TextStyle(color: Colors.black)),
        ],
      )),
    );
  }
}

class BackgroundColor extends StatelessWidget {
  const BackgroundColor({Key? key}) : super(key: key);

  get title => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 96, 97, 97),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 300,
          child: Card(
            child: RegisterPage(),
          ),
        ),
      ),
    );
  }
}
