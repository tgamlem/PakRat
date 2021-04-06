import 'package:PakRat/paks.dart';
import 'package:PakRat/widgets/pakModal.dart';
import "package:flutter/material.dart";
import 'package:PakRat/pakData.dart';

class AddPakItemModal extends StatefulWidget {
  String pakName = "";

  AddPakItemModal(String pname) {
    pakName = pname;
  }

  @override
  _AddPakItemModalState createState() => _AddPakItemModalState(pakName);
}

class _AddPakItemModalState extends State<AddPakItemModal> {
  String title = "";
  String desc = "";
  String pakName = "";

  _AddPakItemModalState(String pakName) {
    this.pakName = pakName;
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
                  onPressed: () async {
                    PakDataItem dataItem = PakDataItem(title, desc);
                    PakData data = await getPak(pakName);
                    data.addItem(dataItem);
                    await setOrUpdatePak(data);
                    navigateToPaks(context, pakName);
                  },
                  child: Text("ADD", style: TextStyle(fontSize: 16)),
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
