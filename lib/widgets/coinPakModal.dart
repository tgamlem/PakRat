import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/camera_screen.dart';

class CoinPakModal extends StatefulWidget {
  String pakName = "";
  String imgURL = "";

  CoinPakModal(String pname) {
    pakName = pname;
  }

  CoinPakModal.img(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  _CoinPakModalState createState() => _CoinPakModalState(pakName, imgURL);
}

class _CoinPakModalState extends State<CoinPakModal> {
  String pakName = "";
  String type = "";
  String mint = "";
  String year = "";
  String condition = "";
  String worth = "";
  String history = "";
  String imgURL = "";

  _CoinPakModalState(String pname, String img) {
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
                      navigateToCamera(context, pakName, "coin");
                    }),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                    maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Type",
                  ),
                  onChanged: (value) => type = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mint",
                  ),
                  onChanged: (value) => mint = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Year",
                  ),
                  onChanged: (value) => year = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                    maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Condition",
                  ),
                  onChanged: (value) => condition = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                    maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Estimated Value",
                  ),
                  onChanged: (value) => worth = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                    maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "History",
                  ),
                  onChanged: (value) => history = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  // add item to database
                  onPressed: () async {
                    List<String> values = [
                      year,
                      mint,
                      condition,
                      worth,
                      history
                    ];
                    PakDataItem dataItem = new PakDataItem(type, values, i: imgURL);
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
