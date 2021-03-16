import 'package:PakRat/widgets/sideMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Auther ath = new Auther();
  String username = "";
  String password = "";
  String id = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: 
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "username",
                ),
                onChanged: (value) => username = value,
              ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 16, 10, 10),
            child: 
              TextField(
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
                child: 
                  ElevatedButton(
                    child: Text('sign up'),
                    onPressed: () => ath.register(username, password),
                  ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(6, 8, 0, 0),
                child: 
                  ElevatedButton(
                    child: Text('log in'),
                    onPressed: () => ath.signIn(username, password),
                  ),
              ),
              
            ],
          ),
          Text("$id"),
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
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print("no user yet");
    //   } else {
    //     print("user exists");
    //     print(user.toString());
    //   }
    // });
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

  void signIn(email, password) async {
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}