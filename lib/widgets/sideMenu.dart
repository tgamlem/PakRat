import 'package:flutter/material.dart';

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
              'Side Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('img/logo.png')),
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
              ListTile(
                title: Text('Books'),
                onTap: () => {navigateToPaks(context)},
              ),
              ListTile(
                title: Text('Movies'),
                onTap: () => {navigateToHome(context)},
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
