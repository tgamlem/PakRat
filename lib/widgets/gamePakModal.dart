import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/camera_screen.dart';

class GamePakModal extends StatefulWidget {
  String pakName = "";
  String imgURL = "";

  GamePakModal(String pname) {
    pakName = pname;
  }

  GamePakModal.img(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  _GamePakModalState createState() => _GamePakModalState(pakName, imgURL);
}

class _GamePakModalState extends State<GamePakModal> {
  String pakName = "";
  String title = "";
  String date = "";
  String genre = "";
  String platform = "";
  String description = "";
  String imgURL = "";

  _GamePakModalState(String pname, String img) {
    pakName = pname;
    imgURL = img;
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
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imgURL != "")
                Image.network(
                  imgURL,
                  width: 100,
                  height: 100,
                ),
              if (imgURL == "")
                IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      navigateToCamera(context, pakName, "game");
                    }),
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
                  keyboardType: TextInputType.multiline,
                    maxLines: null,
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
                    PakDataItem dataItem = new PakDataItem(title, values, i: imgURL);
                    PakData data = await getPak(pakName);
                    data.addItem(dataItem);
                    await setOrUpdatePak(data);
                    navigateToPaks(context, pakName);
                  },
                  child: Text("ADD",
                      style:
                          TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}

Future navigateToCamera(context, String pakName, String form) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CameraScreen(pakName, form)));
}
