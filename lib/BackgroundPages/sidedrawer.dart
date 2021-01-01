import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/BackgroundPages/wrapper.dart';
import 'package:test_site/MainPages/calorieCounter.dart';
import 'package:test_site/MainPages/homePage.dart';
import 'package:test_site/MainPages/taskList.dart';
import 'package:test_site/MainPages/workoutPlanner.dart';
import 'package:test_site/Services/auth.dart';
import 'package:test_site/Services/user.dart';

class SideDrawer extends StatelessWidget {
  AuthService _authService = AuthService();

  Widget _createHeader(Users user) {
    if (user.name.length <= 25) {
      return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/dog-4118585_1920.jpg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/dog-4118585_1920.jpg'),
          ),
        ),
        child: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(user),
          Divider(
            height: 10,
          ),
          new FlatButton.icon(
            label: Text('Home'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            },
            icon: Icon(Icons.home_outlined),
          ),
          Divider(),
          // new FlatButton.icon(
          //     label: Text('Forum'),
          //     onPressed: () {
          //       Navigator.pop(context);
          //       Navigator.push(
          //         context,
          //         PageRouteBuilder(
          //           pageBuilder: (context, animation, secondaryAnimation) =>
          //               ForumPage(),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) {
          //             return SlideTransition(
          //               position: Tween<Offset>(
          //                 begin: const Offset(1.0, 0.0),
          //                 end: Offset.zero,
          //               ).animate(animation),
          //               child: SlideTransition(
          //                 position: Tween<Offset>(
          //                   end: const Offset(1.0, 0.0),
          //                   begin: Offset.zero,
          //                 ).animate(secondaryAnimation),
          //                 child: child,
          //               ),
          //             );
          //           },
          //         ),
          //       );
          //     },
          //     icon: Icon(Icons.forum)),
          // Divider(),
          // new FlatButton.icon(
          //   label: Text('Workout Planner'),
          //   onPressed: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => WorkoutPlaner(),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.calendar_today_outlined),
          // ),
          //Divider(),
          new FlatButton.icon(
            label: Text('Tasks'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TaskList(
                    showCompleted: false,
                  ),
                ),
              );
            },
            icon: Icon(Icons.check_circle_outline),
          ),
          Divider(),
          new FlatButton.icon(
            label: Text('Calorie Counter'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CalorieCounter(),
                ),
              );
            },
            icon: Icon(Icons.assessment_outlined),
          ),
          Divider(),
          FlatButton.icon(
            onPressed: () async {
              //await _authService.googleSignIn.signOut();
              await _authService.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Wrapper(),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Sign Out'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
