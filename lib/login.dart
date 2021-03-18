import 'package:PakRat/widgets/sideMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Auther ath = new Auther();
  String username = "";
  String password = "";
  String id = "";
  String uid = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text('Login')),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "username",
              ),
              onChanged: (value) => username = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 16, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "password",
              ),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 6, 0),
                child: ElevatedButton(
                  child: Text('sign up'),
                  onPressed: () => ath.register(username, password),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(6, 8, 0, 0),
                child: ElevatedButton(
                  child: Text('log in'),
                  onPressed: () => ath.signIn(username, password),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class Auther {
  Auther() {
    initialize();
  }

  var instance;
  UserCredential? user = null;

  void initialize() {
    instance = FirebaseAuth.instance;
  }

  String getId() {
    return user?.user?.uid.toString() ?? "";
  }

  void register(email, password) async {
    bool success = true;
    try {
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak password, try again");
      } else if (e.code == 'email-already-in-use') {
        print("email already exists");
      }
      success = false;
    } catch (e) {
      print(e);
      success = false;
    }
    if (success) {
      print(user?.user?.uid.toString());
      saveUID(getId());
    }
  }

  void signIn(email, password) async {
    bool success = true;
    try {
      this.user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      success = false;
    } catch (e) {
      print(e);
      success = false;
    }
    if (success) {
      print(user?.user?.uid.toString());
      saveUID(getId());
    }
  }

  void saveUID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', id);
  }

  Future<String> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('user_id')!;
    print(id);
    return id;
  }
}
