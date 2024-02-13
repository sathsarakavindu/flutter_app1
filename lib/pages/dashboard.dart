import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_auth/firebase_auth_services.dart';
import 'package:myapp/login_and_register/login.dart';
import 'package:myapp/pages/drawer.dart';
import 'package:myapp/pages/editProfile.dart';
import 'package:myapp/pages/history.dart';
import 'package:myapp/pages/quantity.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Dashboard"),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                myDrawer(),
                Padding(padding: EdgeInsets.only(top: 100)),
                ListTile(
                  tileColor: Color.fromARGB(255, 217, 226, 243),
                  leading: Icon(Icons.edit_document),
                  title: Text("Edit Profile"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => editProfile()));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 217, 226, 243),
                  leading: Icon(Icons.history_rounded),
                  title: Text("History"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => History()));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 217, 226, 243),
                  leading: Icon(Icons.production_quantity_limits_sharp),
                  title: Text("Quantity"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Quantity()));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 217, 226, 243),
                  leading: Icon(Icons.login_outlined),
                  title: Text("Log Out"),
                  onTap: () {
                    try {
                      FirebaseAuthService().signOut();
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
try {
                        FirebaseAuthService().signOut();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      }

*/
