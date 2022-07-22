import 'dart:async';
import 'package:firebase_project_four/model/push_notification_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>PushNotificationTwo()))
    );
    return Scaffold(
     body: Center(
       child: CircleAvatar(
         child: CircularProgressIndicator(
           color: Colors.yellow,
         ),
       ),
     ),
    );
  }
}
