import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/camera_screen.dart';

class BookPakModal extends StatefulWidget {
  String pakName = "";
  String imgURL = "";

  BookPakModal(String pname) {
    pakName = pname;
  }

  BookPakModal.img(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  _BookPakModalState createState() => _BookPakModalState(pakName, imgURL);
}

class _BookPakModalState extends State<BookPakModal> {
  String pakName = "";
  String title = "";
  String author = "";
  String date = "";
  String genre = "";
  String isbn = "";
  String summary = "";
  String imgURL = "";

  _BookPakModalState(String pname, String imgURL) {
    pakName = pname;
    this.imgURL = imgURL;
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
                  Image.network(imgURL,
                    width: 100,
                    height: 100,),
                if (imgURL == "")
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      navigateToCamera(context, pakName, "book");
                    }),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Book Title",
                    ),
                    onChanged: (value) => title = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Author",
                    ),
                    onChanged: (value) => author = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Publication Date",
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
                      labelText: "ISBN",
                    ),
                    onChanged: (value) => isbn = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Book Description",
                    ),
                    onChanged: (value) => summary = value,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () async {
                      List<String> values = [
                        author,
                        date,
                        genre,
                        isbn,
                        summary
                      ];
                      PakDataItem dataItem = new PakDataItem(title, values);
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

Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}

Future navigateToCamera(context, String pakName, String form) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CameraScreen(pakName, form)));
}
