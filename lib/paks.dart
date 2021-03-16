import 'package:PakRat/widgets/sideMenu.dart';
import 'package:flutter/material.dart';

class Paks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Paks'),
      ),
      body: Center(
        child: Text('My Paks'),
      ),
    );
  }
}
