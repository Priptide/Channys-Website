import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_site/BackgroundPages/sidedrawer.dart';

class WorkoutPlaner extends StatefulWidget {
  @override
  _WorkoutPlanerState createState() => _WorkoutPlanerState();
}

class _WorkoutPlanerState extends State<WorkoutPlaner> {
  Map<DateTime, List<dynamic>> _events;
  CalendarController _calendarController;
  String errorMsg = "";
  DateTime currentDate;
  bool isBooked = false;
  Future<bool> isUnavaliable;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    isUnavaliable = Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Planner"),
      ),
      drawer: SideDrawer(),
      body: Column(
        children: [
          TableCalendar(
            events: _events,
            calendarStyle: CalendarStyle(
              todayColor: Colors.grey,
              selectedColor: Colors.black,
              markersColor: Colors.blue,
            ),
            calendarController: _calendarController,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.saturday,
            onDaySelected: (date, events) {
              // if (events.length == 0) {
              //   //print("No Events");
              //   setState(() {
              //     isUnavaliable = Future<bool>.value(true);
              //   });
              // } else {
              //   setState(() {
              //     isUnavaliable = Future<bool>.value(false);
              //     isBooked = events[2];
              //   });
              // }
              // setState(() {
              //   currentDate = date;
              // });
              print(date);
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
