import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/widgets/pakModal.dart';
import 'package:PakRat/widgets/addPakItemModal.dart';
import 'package:PakRat/pakData.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:PakRat/widgets/bookPakModal.dart';
import 'package:PakRat/widgets/moviePakModal.dart';
import 'package:PakRat/widgets/gamePakModal.dart';
import 'package:PakRat/widgets/coinPakModal.dart';

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
              body: HawkFabMenu(
                icon: AnimatedIcons.menu_close,
                fabColor: HexColor("9e9e9e"),
                items: [
                  HawkFabMenuItem(
                    label: "Books",
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BookPakModal(pakName);
                          });
                    },
                    icon: Icon(Icons.book_outlined),
                  ),
                  HawkFabMenuItem(
                    label: "Movies",
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MoviePakModal(pakName);
                          });
                    },
                    icon: Icon(Icons.movie_outlined),
                  ),
                  HawkFabMenuItem(
                    label: "Games",
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GamePakModal(pakName);
                          });
                    },
                    icon: Icon(Icons.videogame_asset_outlined),
                  ),
                  HawkFabMenuItem(
                    label: "Coins",
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CoinPakModal(pakName);
                          });
                    },
                    icon: Icon(Icons.attach_money_outlined),
                  ),
                  HawkFabMenuItem(
                    label: "Other",
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddPakItemModal(pakName);
                          });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              body: Center(
                child: Container(
                  child: GridView.builder(
                    itemCount: futureResult.data?.dataItems.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext ctx, index) {
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
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                              Center(
                                child: Column(
                                  children: [
                                    if (item.image != null && item.image != "")
                                            Image.network(item.image,
                                              width: 160,
                                              height: 160,),
                                            if (item.image == "" || item.image == null)
                                            Image.asset(
                                          'img/PakRat_White.png',
                                          width: 160,
                                          height: 160,
                                        ),
                                    Padding(
                                      padding : EdgeInsets.fromLTRB(12,4,0,4),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
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
                                              item.value,
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
                              ),
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
                            },
                            );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          );
        }
      });
  }
}
