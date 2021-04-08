import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
  
Future<String> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('user_id');
  if (uid != null && uid != "")
    return uid;
  else
    return "";
}

// Used to get pak from Firestore
Future<PakData> getPak(String pakName) async {
  const String COLLECTION = 'paks';
  String uid = await getUid();

  if (uid == "") throw new Exception("Cannot read pak because uid is empty");
  if (pakName == "")
    throw new Exception("Cannot read pak because pak name is empty");

  // get pak name as collection
  var pak = FirebaseFirestore.instance
      .collection(COLLECTION)
      .doc(uid)
      .collection(COLLECTION)
      .doc(pakName);
  var data = await pak.get();
  // get data field off of pak collection or empty string
  var pakDataItems = data.data()?['data'].toString() ?? "";
  // decode json
  final List items = json.decode(pakDataItems);
  // cast to PakDataItem
  final List<PakDataItem> pakDataItemsList =
      items.map((item) => PakDataItem.fromJson(item)).toList();

  final PakData pakData = PakData(pakDataItemsList, pakName);

  return pakData;
}

  // Used to add or update a pak in firestore
Future<bool> setOrUpdatePak(PakData pakData) async {
  const String COLLECTION = "paks";

  String uid = await getUid();
  String json = pakData.toJson();
  bool success = false;
  if (json == "")
    throw new Exception("Cannot update pak because json is empty");
  if (uid == "")
    throw new Exception("Cannot update pak because uid is empty");
  if (pakData.pakName == "")
    throw new Exception("Cannot update pak because pak name is empty");
 
  await FirebaseFirestore.instance
      .collection(COLLECTION)
      .doc(uid)
      .collection(COLLECTION)
      .doc(pakData.pakName)
      .set({
        'uid': uid,
        'pakName': pakData.pakName,
        'data': json,
      }, new SetOptions(merge: true))
      .then((value) => success = true)
      // ignore: return_of_invalid_type_from_catch_error
      .catchError((error) => print("$error"));

  return success;
}

Future<List<String>> getAllPakNames() async {
  const String COLLECTION = "paks";
  String uid = await getUid();
  List<String> names = <String>[];

  var document = await FirebaseFirestore.instance
      .collection(COLLECTION)
      .doc(uid)
      .collection(COLLECTION)
      .get();

  document.docs.forEach((doc) => {names.add(doc.id)});

  return names;
}


class PakData {
  List<PakDataItem> dataItems = [];
  String pakName = "";

  PakData(List<PakDataItem> d, String n) {
    dataItems = d;
    pakName = n;
  }

  addItem(PakDataItem item) {
    dataItems.add(item);
  }

  removeItem(PakDataItem itemToRemove) {
    for (var item in dataItems) {
      if (itemToRemove.title == item.title && itemToRemove.value == item.value)
        dataItems.remove(item);
    }
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
  /// Title of pak entry
  String title = "";

  /// Value of pak entry
  String value = "";

  PakDataItem(String t, String v) {
    title = t;
    value = v;
  }

  PakDataItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
        "title": title,
        'value': value,
      };
}