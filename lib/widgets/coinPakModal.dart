import 'package:PakRat/paks.dart';
import 'package:flutter/material.dart';
import 'package:PakRat/pakData.dart';
import 'package:hexcolor/hexcolor.dart';

class CoinPakModal extends StatefulWidget {
  String pakName = "";

  CoinPakModal(String pname) {
    pakName = pname;
  }

  @override
  _CoinPakModalState createState() => _CoinPakModalState(pakName);
}

class _CoinPakModalState extends State<CoinPakModal> {
  String pakName = "";
  String type = "";
  String mint = "";
  String year = "";
  String condition = "";
  String worth = "";
  String history = "";

  _CoinPakModalState(String pname) {
    pakName = pname;
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
                padding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Type",
                  ),
                  onChanged: (value) => type = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mint",
                  ),
                  onChanged: (value) => mint = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Year",
                  ),
                  onChanged: (value) => year = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Condition",
                  ),
                  onChanged: (value) => condition = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Estimated Value",
                  ),
                  onChanged: (value) => worth = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "History",
                  ),
                  onChanged: (value) => history = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    List<String> values = [year, mint, condition, worth, history];
                    PakDataItem dataItem = new PakDataItem(type, values);
                    PakData data = await getPak(pakName);
                    data.addItem(dataItem);
                    await setOrUpdatePak(data);
                    navigateToPaks(context, pakName);
                  },
                  child: Text("ADD", style: TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
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
