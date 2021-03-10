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
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {
              navigateToHome(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.set_meal_outlined),
            title: Text('Paks'),
            onTap: () => {navigateToPaks(context)},
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
