import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/BackgroundPages/sidedrawer.dart';
import 'package:test_site/Services/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user.name.length <= 55) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: SideDrawer(),
        body: Container(
          decoration: (BoxDecoration(
            color: Colors.black,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome, " + user.name + "!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: SideDrawer(),
        body: Container(
          decoration: (BoxDecoration(
            color: Colors.black,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
