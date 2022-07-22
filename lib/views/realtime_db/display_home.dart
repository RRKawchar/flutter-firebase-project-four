import 'package:firebase_project_four/views/realtime_db/realtime_database_display.dart';
import 'package:firebase_project_four/views/realtime_db/realtime_database_insert.dart';
import 'package:flutter/material.dart';

class displayHome extends StatefulWidget {
  const displayHome({Key? key}) : super(key: key);

  @override
  State<displayHome> createState() => _displayHomeState();
}

class _displayHomeState extends State<displayHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Real Time Database",
              style: TextStyle(color: Colors.orangeAccent, fontSize: 30),
            ),
            const SizedBox(
              height: 15,
            ),
           allButton("Insert Data",const RealTimeDatabaseInsert()),
            const SizedBox(height: 15,),
            allButton("Display Data", const RealTimeDatabaseDisplay())
          ],
        ),
      ),
    );
  }
  Widget allButton(String text,var pageName){
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => pageName));
      },
      child: Text(text),
    );
  }
}
