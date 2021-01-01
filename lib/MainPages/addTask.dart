import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_site/MainPages/taskList.dart';
import 'package:test_site/Services/user.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: titleController,
                        decoration: new InputDecoration(
                          labelText: "Enter Title",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLength: 21,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: descriptionController,
                        decoration: new InputDecoration(
                          labelText: "Enter Description",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLength: 140,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                if (titleController.text != "" &&
                    descriptionController.text != "") {
                  addTaskQuery(
                      user, titleController.text, descriptionController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TaskList(
                        showCompleted: false,
                      ),
                    ),
                  );
                } else {
                  print("Error Add Text");
                }
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
              label: Text(
                "Add Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future addTaskQuery(Users user, String name, String description) async {
    Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "toDo": true,
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email)
        .collection("Tasks")
        .doc(DateTime.now().toString())
        .set(data);
  }
}
