import 'package:PakRat/widgets/sideMenu.dart';
import 'package:PakRat/paks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/pakData.dart';

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

    _paks = getAllPakNames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _paks,
        builder: (context, futureResult) {
          if (!futureResult.hasData) {
            return CircularProgressIndicator();
          } else {
            return Scaffold(
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text('Your Paks', style: TextStyle(color: HexColor("444444"))),
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
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item, style: TextStyle(fontSize: 36)),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      navigateToPaks(context, item);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 10, width: 0);
                },
              ),
            );
          }
        });
  }
}

Future<String> getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('user_id')!;
  print(id);
  return id;
}

Future navigateToPaks(context, String pakName) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}
