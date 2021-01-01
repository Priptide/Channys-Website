import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/MainPages/homePage.dart';
import 'package:test_site/MainPages/signIn.dart';
import 'package:test_site/Services/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    //Return Home Or Authenticate Widget

    if (user != null) {
      //print("Logged In");
      return HomePage();
    } else {
      return SignInPage();
    }
  }
}
