// import 'dart:html';

// import 'package:PakRat/widgets/sideMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:PakRat/widgets/pakModal.dart';
// import 'package:PakRat/widgets/addPakItemModal.dart';
// import 'package:PakRat/pakData.dart';

// class Wishlist extends StatefulWidget {
//   @override
//   WishlistState createState() {
//     return WishlistState();
//   }
// }

// class WishlistState extends State<Wishlist> {
//   late Future<PakData> pakData;
//   @override
//   void initState() {
//     super.initState();

//     pakData = getPak ("TEST");
//   }

//   @override 
//   Widget build(BuildContext context) {
//     return FutureBuilder<PakData>(
//         future: pakData,
//         builder: (context, futureResult) {
//           if (!futureResult.hasData) {
//             return CircularProgressIndicator();
//           } else {
//             return Scaffold(
//               drawer: SideMenu(),
//               appBar: AppBar(
//                 title: Text("Wishlist"),
//               ),
//             );
//             body: Padding(
//               padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
//               child: ListView.builder(
//                 itemCount: futureResult.data!.dataItems.length,
//                 itemBuilder: (context, index) {
//                   final item = futureResult.data!.dataItems[index];

//                   return GestureDetector(
//                     child: Dismissible(
//                       key: Key(item.title),
//                       onDismissed: (direction) {
//                         setState(() {
//                           futureResult.data!.dataItems.removeAt(index);
//                         });

//                         PakData _pakData = futureResult.data!;
//                         _pakData
//                           .removeItem(PakDataItem(item.title, item.value));
//                           setOrUpdatePak(_pakData);

//                           ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("${item.title} dismissed")));
//                       },
//                     )
//                   )

//                 }
//               )
//             )
//           }
//         }
//     )
//   }
// }
