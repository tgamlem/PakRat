import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../login.dart';
import '../main.dart';
import '../paks.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'PakRat',
              style: TextStyle(color: HexColor("757575"), fontSize: 24),
            ),
            decoration: BoxDecoration(
              color: HexColor("d7ccc8"),
              // image: DecorationImage(
              //     fit: BoxFit.fill, image: AssetImage('img/logo.png')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () => {navigateToLogin(context)}),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {navigateToHome(context)},
          ),
          ExpansionTile(
            leading: Icon(Icons.toc_rounded),
            title: Text('Paks'),
            children: [
              ListTile(
                title: Text('Books'),
                onTap: () => {navigateToPaks(context)},
              ),
              ListTile(
                title: Text('Movies'),
                onTap: () => {navigateToPaks(context)},
              ),
              ListTile(
                title: Text('Coins'),
                onTap: () => {navigateToPaks(context)},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future navigateToHome(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

Future navigateToPaks(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Paks()));
}

Future navigateToLogin(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}
