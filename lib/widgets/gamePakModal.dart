import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';

class GamePakModal extends StatefulWidget {
  String pakName = "";

  GamePakModal(String pname) {
    pakName = pname;
  }

  @override
  _GamePakModalState createState() => _GamePakModalState(pakName);
}

class _GamePakModalState extends State<GamePakModal> {
  String pakName = "";
  String title = "";
  String date = "";
  String genre = "";
  String platform = "";
  String description = "";

  _GamePakModalState(String pname) {
    pakName = pname;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Game Title",
                  ),
                  onChanged: (value) => title = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Release Date",
                  ),
                  onChanged: (value) => date = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Genre",
                  ),
                  onChanged: (value) => genre = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Platform",
                  ),
                  onChanged: (value) => platform = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Game Description",
                  ),
                  onChanged: (value) => description = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    List<String> values = [genre, date, platform, description];
                    PakDataItem dataItem = new PakDataItem(title, values);
                    PakData data = await getPak(pakName);
                    data.addItem(dataItem);
                    await setOrUpdatePak(data);
                    navigateToPaks(context, pakName);
                  },
                  child: Text("ADD", style: TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future navigateToPaks(context, String pakName) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}
