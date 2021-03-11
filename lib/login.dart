import 'package:PakRat/widgets/sideMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auther ath = new Auther();
    String username = "";
    String password = "";
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text('Login')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: Text('log in'),
            onPressed: () => ath.register(username, password),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "username",
            ),
            onChanged: (value) => username = value,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "password",
            ),
            obscureText: true,
            onChanged: (value) => password = value,
          ),
          Text(ath.getId()),
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
  var user;

  void initialize() {
    instance = FirebaseAuth.instance;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("no user");
      } else {
        print("user exists");
        print(user.toString());
      }
    });
  }

  String getId() {
    if (user == null)
      return "no user";
    else
      return user.toString();
  }

  void register(email, password) async {
    try {
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak password, try again");
      } else if (e.code == 'email-already-in-use') {
        print("email already exists");
      }
    } catch (e) {
      print(e);
    }
  }
}
