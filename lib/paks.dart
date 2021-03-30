import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/widgets/pakModal.dart';
import 'package:PakRat/widgets/addPakItemModal.dart';
import 'package:PakRat/pakData.dart';

// Learned about FutureBuilder here: https://flutterigniter.com/build-widget-with-async-method-call/

class Paks extends StatelessWidget {
  String text = "";
  String desc = "";
  // List<Widget> children = <Widget>[];
  var data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PakData>(
        future: getPak("TEST"),
        builder: (contect, data) {
          if (data.data == null)
            // return Image(image: AssetImage('img\Pakrat_White.png'));
            return CircularProgressIndicator();
          else {
            // buildChildren();
            return Scaffold(
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text('Paks'),
              ),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                  child: ListView(
                    children: [
                      // children list/array
                      for (final widget in data.data?.dataItems ?? [])
                        GestureDetector(
                          child: Dismissible(
                            key: Key(widget.title),
                            child: Card(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.title,
                                        style: TextStyle(fontSize: 36))
                                  ],
                                ),
                              ),
                            ),
                            background: Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(Icons.delete),
                              alignment: Alignment.centerLeft,
                              color: Colors.red[700],
                            ),
                            confirmDismiss: (dismissDirection) {
                              return showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Delete task?\n(This action will permanately delete this item)",
                                        //style: GoogleFonts.openSans()
                                      ),
                                      actions: <Widget>[
                                        // button to confirm delete
                                        TextButton(
                                          child: Text("Delete"),
                                          onPressed: () async {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                        // button to cancel deleting
                                        TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            direction: DismissDirection.startToEnd,
                            onDismissed: (dismissDirection) async {
                              try {
                                PakDataItem item =
                                    PakDataItem(widget.title, widget.value);
                                PakData pakData = data.data?.removeItem(item);
                                //data.data?.dataItems.remove(item);
                                await setOrUpdatePak(pakData);
                                print("hello");
                              } catch (e) {
                                print("something went wrong: $e");
                              }
                            },
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PakModal(
                                    widget.title,
                                    widget.value,
                                  );
                                });
                          },
                        ),
                    ],
                  )),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: HexColor("bbdefb"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddPakItemModal("TEST");
                      });
                },
              ),
            );
          }
        });
  }

  void buildChildren() {
    // for(widget in data.data) {
      // ...stuff
    // }
  }

  void removeChild() {
    // pakDataItem.removeItem(item);
    // children = pakDataItems;
  }
}
