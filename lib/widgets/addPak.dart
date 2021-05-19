import 'package:PakRat/paks.dart';
import 'package:PakRat/widgets/pakModal.dart';
import "package:flutter/material.dart";
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';

class AddPak extends StatefulWidget {
  @override
  _AddPakState createState() => _AddPakState();
}

class _AddPakState extends State<AddPak> {
  String pakName = "";

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pak Name",
                  ),
                  onChanged: (value) => pakName = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    PakData data = new PakData([], pakName);
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
      ],
    );
  }
}

// navigate to the Paks page
Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}
