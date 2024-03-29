import 'package:PakRat/paks.dart';
import 'package:PakRat/widgets/pakModal.dart';
import "package:flutter/material.dart";
import 'package:PakRat/pakData.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/camera_screen.dart';

class AddPakItemModal extends StatefulWidget {
  String pakName = "";
  String imgURL = "";

  AddPakItemModal(String pname) {
    pakName = pname;
  }

  AddPakItemModal.img(String pname, String img) {
    pakName = pname;
    imgURL = img;
  }

  @override
  _AddPakItemModalState createState() => _AddPakItemModalState(pakName, imgURL);
}

class _AddPakItemModalState extends State<AddPakItemModal> {
  String title = "";
  String desc = "";
  String pakName = "";
  String imgURL = "";

  _AddPakItemModalState(String pakName, String imgURL) {
    this.pakName = pakName;
    this.imgURL = imgURL;
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
                      navigateToCamera(context, pakName, "other");
                    }),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "title",
                    ),
                    onChanged: (value) => title = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "description",
                    ),
                    onChanged: (value) => desc = value,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    // add item to database
                    onPressed: () async {
                      PakDataItem dataItem = PakDataItem(title, [desc], i: imgURL);
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
          )
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
