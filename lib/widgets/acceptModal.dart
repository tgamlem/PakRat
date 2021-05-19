import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:PakRat/pakData.dart';
import 'package:PakRat/wishlist.dart';
import 'package:PakRat/home.dart';

// modal for users to accept to create a wishlist
class AcceptModal extends StatefulWidget {
  final String message;

  const AcceptModal(this.message);

  @override
  _AcceptModalState createState() => _AcceptModalState();
}

class _AcceptModalState extends State<AcceptModal> {
  @override
  Widget build(BuildContext context) {
    // return a dialog box
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }

  // content of the dialog box
  contentBox(context) {
    return Stack(
      children: [
        Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Text(widget.message, style: TextStyle(fontSize: 20)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 4, 4),
                  child: TextButton(
                    onPressed: () {
                      navigateToHome(context);
                    },
                    child: Text("CANCEL",
                        style:
                            TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 4),
                  child: TextButton(
                    onPressed: () async {
                      PakData data = new PakData([], 'Wishlist');
                      await setOrUpdatePak(data);
                      navigateToWishlist(context);
                    },
                    child: Text("ADD",
                        style:
                            TextStyle(fontSize: 16, color: HexColor("bbdefb"))),
                  ),
                ),
              ],
            )
          ],
        )),
      ],
    );
  }
}

// navigate to the wishlist page
Future navigateToWishlist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
}

// navigate to the home page
Future navigateToHome(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}
