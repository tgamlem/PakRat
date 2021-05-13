import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/widgets/pakModal.dart';
import 'package:PakRat/widgets/addPakItemModal.dart';
import 'package:PakRat/pakData.dart';

class Paks extends StatefulWidget {
  String pakName = "";
  Paks(String name) {
    pakName = name;
  }

  @override
  PaksState createState() {
    return PaksState(pakName);
  }
}

class PaksState extends State<Paks> {
  late Future<PakData> pakData;
  bool isHydrated = false;
  String pakName = "";
  PaksState(String name) {
    pakName = name;
  }

  @override
  void initState() {
    super.initState();

    // initial load
    pakData = getPak(pakName);
    isHydrated = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PakData>(
        future: pakData,
        builder: (context, futureResult) {
          if (!isHydrated) {
            return CircularProgressIndicator();
          } else {
            return Scaffold(
              backgroundColor: HexColor("eeeeee"),
              drawer: SideMenu(),
              appBar: AppBar(
                title: Text(pakName),
                leading: BackButton(color: Colors.black,),
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                child: ListView.builder(
                  itemCount: futureResult.data?.dataItems.length ?? 0,
                  itemBuilder: (context, index) {
                    if (futureResult.data == null) {
                      return Container();
                    } else {

                    
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

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${item.title} dismissed")));
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
                                    "Delete item?\n(This action will permanately delete this item)",
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
                          color: HexColor("fcfcfc"),
                          child: Wrap(direction: Axis.horizontal, children: [
                            Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 4, 0, 4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'img/PakRat_White.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * .8,
                                          child: Text(
                                            item.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * .8,
                                          child: Text(
                                            item.value[0],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: HexColor("8d8d8d")), 
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
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
                  }
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: HexColor("9e9e9e"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddPakItemModal(pakName);
                      });
                },
              ),
            );
          }
        });
  }
}
