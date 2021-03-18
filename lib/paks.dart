import 'dart:convert';
import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paks extends StatelessWidget {
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Paks'),
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "text",
            ),
            onChanged: (value) => text = value,
          ),
          ElevatedButton(
            child: Text("Save to Database"),
            onPressed: () => addUserText(text),
          ),
          ElevatedButton(
            child: Text("Read from Database"),
            onPressed: () => readFromDatabase(),
          ),
        ],
      ),
    );
  }

  final String document = "PAKS";

  void addUserText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('user_id')!;
    CollectionReference paks = FirebaseFirestore.instance.collection('packs');

    PakData data = new PakData();
    data.addItem(
        new PakDataItem.setUpWithData("test title", "test description"));
    String json = data.toJson();

    paks
        .add({
          'uid': uid,
          'pak_name': "TEST",
          'data': json,
        })
        .then((value) => print("YAY! WE PUSHED TO THE DATABASE!"))
        .catchError((error) => print(":( $error"));
  }

  void readFromDatabase() async {
    var snapshot = await FirebaseFirestore.instance.collection('packs').get();
    var docs = snapshot.docs;
    var json = docs.first.data()?['data'];
    var dataAsJson = jsonDecode(json);
    print(dataAsJson['title']);
    PakDataItem dataItem = PakDataItem.fromJson(dataAsJson);
    print(dataItem.getTitle());
    // var data = paks.fromJson();
  }
}

class PakData {
  List<PakDataItem> dataItems = [];

  addItem(PakDataItem item) {
    dataItems.add(item);
  }

  String toJson() {
    String json = "";
    for (var item in dataItems) {
      json += jsonEncode(item);
    }
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
