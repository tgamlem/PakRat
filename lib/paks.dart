import 'dart:convert';
import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/widgets/pakModal.dart';
import 'package:PakRat/widgets/addPakItemModal.dart';

// Learned about FutureBuilder here: https://flutterigniter.com/build-widget-with-async-method-call/

class Paks extends StatelessWidget {
  String text = "";
  String desc = "";
  var data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PakDataItem>>(
        future: readFromDatabase(),
        builder: (contect, data) {
          if (data.data == null)
            // return Image(image: AssetImage('img\Pakrat_White.png'));
            return CircularProgressIndicator();
          else {
            return Scaffold(
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text('Paks'),
              ),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                  child: ListView(
                    children: [
                      for (final widget in data.data ?? [])
                        //Text(widget.title)
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
                            title: Text("Delete task?",
                              //style: GoogleFonts.openSans()
                            ),
                            actions: <Widget>[
                              // button to confirm delete
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () {
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
                        }
                      );
                            },
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PakModal(
                                  widget.title,
                                  widget.description,
                                );
                              }
                            );
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
                      return AddPakItemModal();
                    }
                  );
                },
              ),
            );
          }
        });
    // return Scaffold(
    //   drawer: SideMenu(),
    //   appBar: AppBar(
    //     title: Text('Paks'),
    //   ),
    //   body: ListView(
    //     children: [
    //       ElevatedButton(
    //         child: Text("Read from Database"),
    //         onPressed: () => data = readFromDatabase(),
    //       ),
    //       if (data != null)
    //         for (final widget in data) Text(widget.title),
    // if (data != null) {
    //   var textElements = []
    //   for (final widget in data)
    //     textElements.add(Text(widget.title))
    //   return textelements
    // }
    // TextField(
    //   decoration: InputDecoration(
    //     border: OutlineInputBorder(),
    //     labelText: "title",
    //   ),
    //   onChanged: (value) => text = value,
    // ),
    // TextField(
    //   decoration: InputDecoration(
    //       border: OutlineInputBorder(), labelText: "description"),
    //   onChanged: (value) => desc = value,
    // ),
    // ElevatedButton(
    //   child: Text("Save to Database"),
    //   onPressed: () => addUserText(text, desc),
    // ),
    // ElevatedButton(
    //   child: Text("Read from Database"),
    //   onPressed: () => readFromDatabase(),
    // ),
    //     ],
    //   ),
    // );
  }

  final String document = "PAKS";

  void addUserText(String text, String desc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('user_id')!;
    CollectionReference paks = FirebaseFirestore.instance.collection('paks');

    PakData data = new PakData();
    data.addItem(new PakDataItem.setUpWithData(text, desc));
    data.addItem(new PakDataItem.setUpWithData("foo", "bar"));
    String json = data.toJson();
    // String json = '[';
    // for (var item in data.dataItems) {
    //   json += item.toJson().toString();
    //   json += ',';
    // }
    // json += ']';

    paks
        .doc(uid)
        .collection('paks')
        .doc("TEST")
        .set({
          'uid': uid,
          'pak_name': "TEST",
          'data': json,
        }, new SetOptions(merge: true))
        .then((value) => print("YAY! WE PUSHED TO THE DATABASE!"))
        .catchError((error) => print(":( $error"));
  }

  Future<List<PakDataItem>> readFromDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('user_id')!;
    // get pak name as collection
    var pak = await FirebaseFirestore.instance
        .collection('paks')
        .doc(uid)
        .collection('paks')
        .doc('TEST');
    var data = await pak.get();
    // get data field off of pak collection or empty string
    var pakDataItems = data.data()?['data'].toString() ?? "";
    // decode json
    final List items = json.decode(pakDataItems);
    // cast to PakDataItem
    final List<PakDataItem> pakDataItemsList =
        items.map((item) => PakDataItem.fromJson(item)).toList();

    return pakDataItemsList;
    //var objects = pakDataItems?.map((element) => jsonDecode(element));
    //print(objects?.first['title']);
    //var dataAsJson = jsonDecode(json.data()?['data']);
    //print(dataAsJson['title']);
    //PakDataItem dataItem = PakDataItem.fromJson(dataAsJson);
    //print(dataItem.getTitle());
    // var data = paks.fromJson();
  }
}

class PakData {
  List<PakDataItem> dataItems = [];

  addItem(PakDataItem item) {
    dataItems.add(item);
  }

  String toJson() {
    String json = "[";
    for (var item in dataItems) {
      json += jsonEncode(item) + ',';
    }
    json = json.substring(0, json.length - 1);
    json += ']';
    return json;
  }
}

class PakDataItem {
  var title;
  var description;

  PakDataItem() {}

  PakDataItem.setUpWithData(String t, String d) {
    title = t;
    description = d;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  void setTitle(String t) {
    title = t;
  }

  void setDescription(String d) {
    description = d;
  }

  PakDataItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
