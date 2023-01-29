import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notification/screens/TEST.dart';
import 'package:flutter_local_notification/screens/alarm.dart';
import 'package:flutter_local_notification/screens/budzik.dart';
import 'package:flutter_local_notification/screens/second_screen.dart';

import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TESTOWANIE.dart';
import 'map.dart';

class home extends StatefulWidget {
  const home({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Uwierz w siebie albo ni "),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          backgroundColor: Color.fromARGB(255, 68, 0, 255),
        ),
        body: Row(children: [
          Column(children: [
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Center(
                  child: Text(DateFormat('hh:mm:ss').format(DateTime.now()),
                      style: TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
                );
              },
            ),
          ]),
          Column(children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => alarm()))),
              style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(255, 127, 0, 255),
                elevation: 5,
                shadowColor: Color.fromARGB(255, 75, 4, 146),
              ),
              child: Text("Budzik"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => map()))),
              style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(255, 127, 0, 255),
                elevation: 5,
                shadowColor: Color.fromARGB(255, 75, 4, 146),
              ),
              child: Text("Mapy"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => note()))),
              style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(255, 127, 0, 255),
                elevation: 5,
                shadowColor: Color.fromARGB(255, 75, 4, 146),
              ),
              child: Text("Notatki"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => budzik()))),
              style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(255, 127, 0, 255),
                elevation: 5,
                shadowColor: Color.fromARGB(255, 75, 4, 146),
              ),
              child: Text("Budzik"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SecondScreen(
                          payload: "huj",
                          question: "kutas",
                          odpowiedz: "sda")))),
              style: ElevatedButton.styleFrom(
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                primary: Color.fromARGB(255, 127, 0, 255),
                elevation: 5,
                shadowColor: Color.fromARGB(255, 75, 4, 146),
              ),
              child: Text("MOWA"),
            ),
          ])
        ]));
  }
}
