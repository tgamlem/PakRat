import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/pakData.dart';

class PakModal extends StatefulWidget {
  final String title;
  final List<String> values;

  const PakModal(this.title, this.values);

  @override
  _PakModalState createState() => _PakModalState();
}

class _PakModalState extends State<PakModal> {
  @override
  Widget build(BuildContext context) {
    // return a dialog with the modal
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(widget.title, style: TextStyle(fontSize: 30)),
                ),
              
                for (final item in widget.values)
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Wrap(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(item + "\n", maxLines: 5, style: TextStyle(fontSize: 20)),
                          ),
                        ] 
                      ),
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("DONE",
                    style: TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
