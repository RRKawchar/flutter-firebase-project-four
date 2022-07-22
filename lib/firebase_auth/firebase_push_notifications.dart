import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebasePushNotifications extends StatefulWidget {
  const FirebasePushNotifications({Key? key}) : super(key: key);

  @override
  State<FirebasePushNotifications> createState() => _FirebasePushNotificationsState();
}

class _FirebasePushNotificationsState extends State<FirebasePushNotifications> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
      print(message.notification!.title);
      print(message.notification!.body);
      }

    });


    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if(message.notification!=null){
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data["path"]);
        Navigator.pushNamed(context, message.data["path"]);
      }

    });

    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message!=null){
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data["path"]);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notifications"),
      ),
    );
  }
}
