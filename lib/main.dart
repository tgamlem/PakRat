import 'package:PakRat/widgets/sideMenu.dart';
import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(App());

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
          primaryColor: HexColor("bbdefb"), accentColor: HexColor("d7ccc8")),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  List<String> _paks = ["Books", "Movies", "Coins", "Mugs"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: HexColor("444444"))),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .01,
          vertical: 10,
        ),
        itemCount: (_paks.length),
        itemBuilder: (context, index) {
          String pak = _paks[index];
          return GestureDetector(
            child: Card(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(pak, style: TextStyle(fontSize: 36)),
                  ],
                ),
              ),
            ),
            onTap: () {
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: Text(pak),
              //       );
              //     });
              navigateToPaks(context);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(height: 10, width: 0);
        },
      ),
    );
  }
}

Future<String> getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('user_id')!;
  print(id);
  return id;
}

Future navigateToPaks(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Paks()));
}
