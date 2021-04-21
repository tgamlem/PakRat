import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../login.dart';
import '../home.dart';
import '../paks.dart';
import '../pakData.dart';
import '../wishlist.dart';

class SideMenu extends StatefulWidget {
  @override
  SideMenuState createState() {
    return SideMenuState();
  }
}

class SideMenuState extends State<SideMenu> {
  late Future<List<String>> _paks;

  @override
  void initState() {
    super.initState();
    _paks = getAllPakNames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _paks,
        builder: (context, futureResult) {
          if (!futureResult.hasData) {
            return CircularProgressIndicator();
          } else {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text(
                      'PakRat',
                      style: TextStyle(color: HexColor("000000"), fontSize: 24),
                    ),
                    decoration: BoxDecoration(
                      color: HexColor("9e9e9e"),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('img/Pakrat_White.png')),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => {navigateToHome(context)},
                  ),
                  ExpansionTile(
                    leading: Icon(Icons.toc_rounded),
                    title: Text('Paks'),
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (futureResult.data!.length),
                          itemBuilder: (context, index) {
                            final item = futureResult.data![index];
                            return ListTile(
                                title: Text(item),
                                onTap: () => {navigateToPaks(context, item)});
                          }),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.star_border_outlined),
                    title: Text('Wishlist'),
                    onTap: () => {navigateToWishlist(context)}
                  ),
                  ListTile(
                      leading: Icon(Icons.login),
                      title: Text('Login'),
                      onTap: () => {navigateToLogin(context)}),
                ],
              ),
            );
          }
        });
  }
}

Future navigateToHome(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}

Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}

Future navigateToLogin(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}

Future navigateToWishlist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
}
