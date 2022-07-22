import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project_four/model/notifacation_badge.dart';
import 'package:firebase_project_four/model/pushNotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationTwo extends StatefulWidget {
  const PushNotificationTwo({Key? key}) : super(key: key);

  @override
  State<PushNotificationTwo> createState() => _PushNotificationTwoState();
}

class _PushNotificationTwoState extends State<PushNotificationTwo> {
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted the permission");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data["title"],
          dataBody: message.data["body"],
        );
        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });
        if (notification != null) {
          showSimpleNotification(Text(_notificationInfo!.title!),
              leading: NotificationBadge(
                  totalNotification: _totalNotificationCounter),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 2));
        }
      });
    } else {
      print("Permission declined by user");
    }
  }
  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data["title"],
        dataBody: initialMessage.data["body"],
      );
      setState((){
        _totalNotificationCounter++;
        _notificationInfo=notification;
      });
    }
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data["title"],
        dataBody: message.data["body"],
      );
      setState((){
        _totalNotificationCounter++;
       _notificationInfo=notification;

      }

      );
    });
     checkForInitialMessage();
    registerNotification();
    _totalNotificationCounter = 0;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "FlutterPushNotification",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            NotificationBadge(totalNotification: _totalNotificationCounter),
            const SizedBox(
              height: 30,
            ),
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
