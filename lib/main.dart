import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/Services/auth.dart';
import 'package:test_site/Services/user.dart';
import 'BackgroundPages/wrapper.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:firebase/firebase.dart';

void main() {
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmgwOzIhPzo2MCE8PDg2EzQ+Mjo/fTA8Pg==");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR");
          } else {
            return StreamProvider<Users>.value(
              value: AuthService().userStream,
              child: MaterialApp(
                  theme: ThemeData(
                    canvasColor: Colors.white,
                    primaryColor: Colors.black,
                  ),
                  home: new Wrapper()),
            );
          }
        });
  }
}
