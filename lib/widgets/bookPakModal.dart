import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';

class BookPakModal extends StatefulWidget {
  String pakName = "";

  BookPakModal(String pname) {
    pakName = pname;
  }

  @override
  _BookPakModalState createState() => _BookPakModalState(pakName);
}

class _BookPakModalState extends State<BookPakModal> {
  String pakName = "";
  String title = "";
  String author = "";
  String date = "";
  String genre = "";
  String isbn = "";
  String summary = "";

  _BookPakModalState(String pname) {
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
                    // PakDataItem dataItem = PakDataItem(title, desc);
                    // PakData data = await getPak(pakName);
                    // data.addItem(dataItem);
                    // await setOrUpdatePak(data);
                    // navigateToPaks(context, pakName);
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
