import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/widgets/pakModal.dart';
import 'package:PakRat/widgets/addPakItemModal.dart';
import 'package:PakRat/pakData.dart';

class Paks extends StatefulWidget {
  @override
  PaksState createState() {
    return PaksState();
  }
}

class PaksState extends State<Paks> {
  late Future<PakData> pakData;

  @override
  void initState() {
    super.initState();

    // initial load
    pakData = getPak("TEST");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PakData>(
        future: pakData,
        builder: (context, futureResult) {
          if (!futureResult.hasData) {
            return CircularProgressIndicator();
          } else {
            return Scaffold(
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text("Paks"),
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                child: ListView.builder(
                  itemCount: futureResult.data!.dataItems.length,
                  itemBuilder: (context, index) {
                    final item = futureResult.data!.dataItems[index];

                    return GestureDetector(
                      child: Dismissible(
                      key: Key(item.title),
                      onDismissed: (direction) {
                        setState(() {
                          futureResult.data!.dataItems.removeAt(index);
                        });

                        PakData _pakData = futureResult.data!;
                        _pakData
                            .removeItem(PakDataItem(item.title, item.value));
                        setOrUpdatePak(_pakData);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${item.title} dismissed")));
                      },
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
                      child: Card(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.title,
                                        style: TextStyle(fontSize: 36))
                                  ],
                                ),
                              ),
                            ),
                    ),
                    onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PakModal(
                                    item.title,
                                    item.value,
                                  );
                                });
                          },
                    );
                  },
                ),
              ),
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
}
