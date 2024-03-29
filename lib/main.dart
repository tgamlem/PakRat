import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PakRat',
      theme: ThemeData(
          primaryColor: HexColor("bbdefb"),
          accentColor: HexColor("607d8b"),
          fontFamily: GoogleFonts.sourceSansPro().fontFamily,
      ),
      home: Login(), // start on login page
    );
  }
}
