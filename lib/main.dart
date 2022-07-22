import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_four/views/realtime_db/display_home.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const displayHome(),
        // routes: {
        //   "recommended":(context)=>Recommended()
        // },
      ),
    );
  }
}