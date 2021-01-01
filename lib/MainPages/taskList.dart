import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/BackgroundPages/sidedrawer.dart';
import 'package:test_site/MainPages/addTask.dart';
import 'package:test_site/Services/user.dart';

class TaskList extends StatefulWidget {
  @override
  final bool showCompleted;
  TaskList({this.showCompleted});
  _TaskListState createState() => _TaskListState(showCompleted: showCompleted);
}

class _TaskListState extends State<TaskList> {
  final bool showCompleted;
  _TaskListState({this.showCompleted});
  @override
  Widget build(BuildContext context) {
    print(showCompleted);
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.flip_camera_android,
          //     size: 25,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => TaskList(
          //           showCompleted: !showCompleted,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      drawer: SideDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user.email)
                      .collection("Tasks")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    final int cardLength = snapshot.data.documents.length;

                    if (!showCompleted) {
                      return new GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                        itemCount: cardLength,
                        itemBuilder: (context, int index) {
                          final DocumentSnapshot _card =
                              snapshot.data.documents[index];
                          print(_card.data().toString());
                          if (_card.data()["toDo"]) {
                            try {
                              return new Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            (_card.data()["name"].toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            (_card
                                                .data()["description"]
                                                .toString()),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.check_box,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              removeCard(
                                                  user, "toDo", _card, false);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              print(e);
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return new GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                        itemCount: cardLength,
                        itemBuilder: (context, int index) {
                          final DocumentSnapshot _card =
                              snapshot.data.documents[index];
                          if (!_card.data()["toDo"]) {
                            try {
                              return new Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            (_card.data()["name"].toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            (_card
                                                .data()["description"]
                                                .toString()),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.undo,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              removeCard(
                                                  user, "toDo", _card, true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              print(e);
                              return Container();
                            }
                          } else {
                            return null;
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AddTask(),
          ),
        ),
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Future removeCard(Users user, String variable,
      DocumentSnapshot documentSnapshot, dynamic updatedValue) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email)
        .collection("Tasks")
        .doc(documentSnapshot.id)
        .delete();
  }
}
