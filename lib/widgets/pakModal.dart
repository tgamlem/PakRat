import "package:flutter/material.dart";

class PakModal extends StatefulWidget {
  final String title, desc;

  const PakModal(this.title, this.desc);

  @override
  _PakModalState createState() => _PakModalState();
}

class _PakModalState extends State<PakModal> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Text("Title:", style: TextStyle(fontSize: 20)),
                ),
                Padding (
                  padding: EdgeInsets.only(top: 20),
                  child: Text(widget.title, style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Text("Description:", style: TextStyle(fontSize: 20)),
                ),
                Padding (
                  padding: EdgeInsets.only(top: 20),
                  child: Text(widget.desc, style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: () {
                Navigator.of(context).pop();},
                child: Text("DONE", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
