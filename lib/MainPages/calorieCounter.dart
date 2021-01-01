import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:test_site/BackgroundPages/sidedrawer.dart';
import 'package:intl/intl.dart';
import 'package:test_site/Services/user.dart';

class CalorieCounter extends StatefulWidget {
  @override
  _CalorieCounterState createState() => _CalorieCounterState();
}

class _CalorieCounterState extends State<CalorieCounter> {
  double progressValue = 0;
  DateTime now = DateTime.now();
  TextEditingController _waterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    String today = (DateFormat('dd-MM-yyyy').format(now)).toString();
    setupFile(user);
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text("Calorie Counter"),
        ),
        drawer: SideDrawer(),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(user.email)
                  .collection("CalorieDiary")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                final int cardLength = snapshot.data.docs.length;
                bool correctDay = false;
                int idCorrect;
                print("Length" + cardLength.toString());
                for (int i = 0; i < cardLength;) {
                  print(snapshot.data.docs[i].id.toString());
                  if (snapshot.data.docs[i].id.toString() == today) {
                    correctDay = true;
                    idCorrect = i;
                    break;
                  } else {
                    i++;
                  }
                }
                print("Through");
                if (correctDay == true) {
                  int i = idCorrect;
                  print(snapshot.data.docs[i]
                          .data()["BreakfastCalories"]
                          .toString() +
                      "45");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          "Date: " + DateFormat('dd/MM/yyyy').format(now),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              _calorieGuage(
                                progressValue: snapshot.data.docs[i]
                                    .data()["BreakfastCalories"] as double,
                                name: "Breakfast",
                                maxValue: 5000,
                                guageColor: Colors.orange,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["BreakfastCalories"] +
                                          100;
                                      addValue(user, "BreakfastCalories",
                                          snapshot.data.docs[i], updatedValue);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["BreakfastCalories"] -
                                          100;
                                      if (updatedValue >= 0)
                                        addValue(
                                            user,
                                            "BreakfastCalories",
                                            snapshot.data.docs[i],
                                            updatedValue);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              _calorieGuage(
                                progressValue: snapshot.data.docs[i]
                                    .data()["LunchCalories"] as double,
                                name: "Lunch",
                                maxValue: 5000,
                                guageColor: Colors.yellow,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["LunchCalories"] +
                                          100;
                                      addValue(user, "LunchCalories",
                                          snapshot.data.docs[i], updatedValue);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["LunchCalories"] -
                                          100;
                                      if (updatedValue >= 0)
                                        addValue(
                                            user,
                                            "LunchCalories",
                                            snapshot.data.docs[i],
                                            updatedValue);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              _calorieGuage(
                                progressValue: snapshot.data.docs[i]
                                    .data()["DinnerCalories"] as double,
                                name: "Dinner",
                                maxValue: 5000,
                                guageColor: Colors.blue,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["DinnerCalories"] +
                                          100;
                                      addValue(user, "DinnerCalories",
                                          snapshot.data.docs[i], updatedValue);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      int updatedValue = snapshot.data.docs[i]
                                              .data()["DinnerCalories"] -
                                          100;
                                      if (updatedValue >= 0)
                                        addValue(
                                            user,
                                            "DinnerCalories",
                                            snapshot.data.docs[i],
                                            updatedValue);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Water",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            height: 27.5,
                            width: 800,
                            child: FAProgressBar(
                              backgroundColor: Colors.white,
                              progressColor: Colors.lightBlue,
                              changeColorValue: 50,
                              changeProgressColor: Colors.blue,
                              currentValue: snapshot.data.docs[i]
                                  .data()["WaterIntake"] as int,
                              maxValue: 2000,
                              displayText: 'ml',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // SizedBox(
                          //   width: 100,
                          //   height: 20,
                          //   child: TextField(
                          //     controller: _waterController,
                          //     decoration: InputDecoration(
                          //       labelText: "Enter water intake (ml)",
                          //       labelStyle: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     style: TextStyle(color: Colors.white),
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: <TextInputFormatter>[
                          //       FilteringTextInputFormatter.digitsOnly
                          //     ],
                          //     onChanged: (str) {
                          //       setState(() {
                          //         str = _waterController.text;
                          //       });
                          //     }, // Only numbers can be entered
                          //   ),
                          // ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              int updatedValue =
                                  snapshot.data.docs[i].data()["WaterIntake"] +
                                      100;
                              addValue(user, "WaterIntake",
                                  snapshot.data.docs[i], updatedValue);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              int updatedValue =
                                  snapshot.data.docs[i].data()["WaterIntake"] -
                                      100;
                              if (updatedValue >= 0)
                                addValue(user, "WaterIntake",
                                    snapshot.data.docs[i], updatedValue);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
        ),
      );
    } catch (e) {
      setupFile(user);
      return Container();
    }
  }

  Future addValue(Users user, String variable,
      DocumentSnapshot documentSnapshot, int updatedValue) async {
    Map<String, dynamic> data = {
      variable: updatedValue,
    };
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.email)
        .collection("CalorieDiary")
        .doc(documentSnapshot.id)
        .update(data);
  }

  Future setupFile(Users user) async {
    String today = (DateFormat('dd-MM-yyyy').format(now)).toString();
    try {
      DocumentSnapshot setup = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .collection("CalorieDiary")
          .doc(today)
          .get();
      if (setup.data()["BreakfastCalories"] == null) {
        Map<String, dynamic> data = {
          "BreakfastCalories": 0,
          "LunchCalories": 0,
          "DinnerCalories": 0,
          "WaterIntake": 0,
        };
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.email)
            .collection("CalorieDiary")
            .doc(today)
            .set(data);
      }
    } catch (e) {
      Map<String, dynamic> data = {
        "BreakfastCalories": 0,
        "LunchCalories": 0,
        "DinnerCalories": 0,
        "WaterIntake": 0,
      };
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .collection("CalorieDiary")
          .doc(today)
          .set(data);
    }
  }
}

class _calorieGuage extends StatelessWidget {
  const _calorieGuage({
    Key key,
    @required this.progressValue,
    @required this.maxValue,
    @required this.name,
    @required this.guageColor,
  }) : super(key: key);

  final double progressValue;

  final double maxValue;

  final String name;

  final Color guageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: maxValue,
              showLabels: false,
              showTicks: true,
              axisLineStyle: AxisLineStyle(
                color: Colors.white,
                thickness: 0.2,
                cornerStyle: CornerStyle.bothCurve,
                //color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: progressValue,
                  cornerStyle: CornerStyle.bothCurve,
                  width: 0.2,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: guageColor,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  positionFactor: 0.1,
                  angle: 90,
                  widget: Text(
                    progressValue.toStringAsFixed(0) + " cal",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }
}
