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
import 'package:PakRat/home.dart';

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
            // if page isn't loaded, display loading screen
            return CircularProgressIndicator();
          } else {
            return Scaffold(
                backgroundColor: HexColor("eeeeee"),
                drawer: SideMenu(),
                appBar: AppBar(
                  title: Text(pakName),
                  leading: BackButton(
                    color: Colors.black,
                    onPressed: () {
                      navigateToHome(context);
                    },
                  ),
                ),
                // special floating action button that expands with multiple options
                  body: HawkFabMenu(
                    icon: AnimatedIcons.menu_close,
                    fabColor: HexColor("9e9e9e"),
                    items: [
                      // book form
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
                      // movie form
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
                      // game form
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
                      // coin form
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
                      // other form
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
                    // the rest of the page
                    body: Center(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                          // display items in a grid
                          child: GridView.builder(
                            itemCount: futureResult.data?.dataItems.length ?? 0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext ctx, index) {
                              if (futureResult.data == null) {
                                return Container();
                              } else {
                                final item =
                                    futureResult.data!.dataItems[index];
                                return GestureDetector(
                                  child: Dismissible(
                                    key: Key(item.title),
                                    direction: DismissDirection.startToEnd,
                                    // slide to delete item
                                    onDismissed: (direction) {
                                      setState(() {
                                        futureResult.data!.dataItems
                                            .removeAt(index);
                                      });

                                      PakData _pakData = futureResult.data!;
                                      _pakData.removeItem(
                                          PakDataItem(item.title, item.value));
                                      setOrUpdatePak(_pakData);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "${item.title} dismissed")));
                                    },
                                    background: Container(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Icon(Icons.delete),
                                      alignment: Alignment.centerLeft,
                                      color: Colors.red[700],
                                    ),
                                    confirmDismiss: (dismissDirection) {
                                      // have users confirm their delete
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
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                ),
                                                // button to cancel deleting
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
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
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Column(
                                                  children: [
                                                    // display custom image or PakRat logo
                                                    if (item.image != null &&
                                                        item.image != "")
                                                      Image.network(
                                                        item.image,
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                    if (item.image == "" ||
                                                        item.image == null)
                                                      Image.asset(
                                                        'img/PakRat_White.png',
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              12, 4, 0, 4),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          // title of item
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .8,
                                                            child: Text(
                                                              item.title,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 30),
                                                            ),
                                                          ),
                                                          // value of item
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .8,
                                                            child: Text(
                                                              item.value[0],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: HexColor(
                                                                      "8d8d8d")),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // display title and values when tapped
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
                    )));
          }
        });
  }
}

// navigate to the home page
Future navigateToHome(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}
