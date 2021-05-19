import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/camera_screen.dart';

class MoviePakModal extends StatefulWidget {
  String pakName = "";
  String imgURL = "";

  MoviePakModal(String pname) {
    pakName = pname;
  }

  MoviePakModal.img(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  _MoviePakModalState createState() => _MoviePakModalState(pakName, imgURL);
}

class _MoviePakModalState extends State<MoviePakModal> {
  String pakName = "";
  String title = "";
  String date = "";
  String genre = "";
  String cast = "";
  String summary = "";
  String imgURL = "";

  _MoviePakModalState(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  Widget build(BuildContext context) {
    // return a dialog box
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }

  // the content of the dialog
  contentBox(context) {
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if there is an image URL, display it
                if (imgURL != "")
                  Image.network(imgURL,
                    width: 100,
                    height: 100,),
                    // if there is no image, display the camera button
                if (imgURL == "")
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      navigateToCamera(context, pakName, "movie");
                    }),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Movie Title",
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cast",
                    ),
                    onChanged: (value) => cast = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "About",
                    ),
                    onChanged: (value) => summary = value,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    // add item to database
                    onPressed: () async {
                      List<String> values = [genre, date, cast, summary];
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
          ),
        ),
      ],
    );
  }
}

// navigate to the Paks page
Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}

// navigate to the Camera page
Future navigateToCamera(context, String pakName, String form) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CameraScreen(pakName, form)));
}
