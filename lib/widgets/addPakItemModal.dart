import 'package:PakRat/widgets/pakModal.dart';
import "package:flutter/material.dart";

class AddPakItemModal extends StatefulWidget {
  const AddPakItemModal();

  @override
  _AddPakItemModalState createState() => _AddPakItemModalState();
}

class _AddPakItemModalState extends State<AddPakItemModal> {
  String title = "";
  String desc = "";

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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ADD", style: TextStyle(fontSize: 16)),
                  // TODO: have this button add the new item to the database and make sure it displays on the paks screen
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
