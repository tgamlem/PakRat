import 'package:PakRat/widgets/sideMenu.dart';
import 'package:PakRat/paks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/pakData.dart';
import 'package:PakRat/widgets/addPak.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  late Future<List<String>> _paks;

  @override
  void initState() {
    super.initState();

    _paks = getAllPakNames(); // get the paks for this user
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _paks,
        builder: (context, futureResult) {
          if (!futureResult.hasData) {
            return CircularProgressIndicator(); // display a loading screen until page is built
          } else {
            return Scaffold(
              backgroundColor: HexColor("eeeeee"),
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text('Your Paks',
                    style: TextStyle(color: HexColor("444444"))),
              ),
              body: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .01,
                  vertical: 10,
                ),
                itemCount: (futureResult.data!.length),
                itemBuilder: (context, index) {
                  final item = futureResult.data![index];
                  return GestureDetector(
                    child: Card(
                      color: HexColor("fcfcfc"),
                      child: Center(
                        child: Column(
                        children: [ 
                          // PakRat logo
                          Image.asset(
                            'img/PakRat_White.png',
                            width: 100,
                            height: 100,
                          ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item, style: TextStyle(fontSize: 30)),
                          ],
                        ),
                        ]),
                    )),
                    onTap: () {
                      navigateToPaks(context, item);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 0, width: 0);
                },
              ),
              // add a new pak
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: HexColor("9e9e9e"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddPak();
                      });
                },
              ),
            );
          }
        });
  }
}

// get userID from local storage
Future<String> getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('user_id')!;
  print(id);
  return id;
}

// navigate to the paks page
Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}
