import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../login.dart';
import '../home.dart';
import '../paks.dart';
import '../pakData.dart';
import '../wishlist.dart';

// PakRat's navigation hub
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
                          fit: BoxFit.contain, image: AssetImage('img/PakRat_White.png')),
                    ),
                  ),
                  // Home screen
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => {navigateToHome(context)},
                  ),
                  // list all pak pages
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
                  // wishlist screen
                  ListTile(
                    leading: Icon(Icons.star_border_outlined),
                    title: Text('Wishlist'),
                    onTap: () => {navigateToWishlist(context)}
                  ),
                  // login screen
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

// navigate to Home page
Future navigateToHome(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}

// navigate to Paks page
Future navigateToPaks(context, String pakName) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Paks(pakName)));
}

// navigate to Login page
Future navigateToLogin(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}

// navigate to Wishlist page
Future navigateToWishlist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
}
