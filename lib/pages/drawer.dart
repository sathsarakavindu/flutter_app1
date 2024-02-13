import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 58, 70, 240),
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: Image.asset(
              "assets/images/waterLogo1.jpg",
              fit: BoxFit.cover,
            ),
            // decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   image: DecorationImage(
            //     image: AssetImage(
            //       "assets/images/waterGlassA.jpg",
            //     ),
            //   ),
            // ),
          ),
          Text(
            "User Name",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "index@gmail.com",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
