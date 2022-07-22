import 'package:firebase_project_four/views/pages/delete_data.dart';
import 'package:firebase_project_four/views/pages/display_data.dart';
import 'package:firebase_project_four/views/pages/insert_data.dart';
import 'package:firebase_project_four/views/pages/update_data.dart';
import 'package:firebase_project_four/views/pages2/delete_record.dart';
import 'package:firebase_project_four/views/pages2/display_record.dart';
import 'package:firebase_project_four/views/pages2/insert_record.dart';
import 'package:firebase_project_four/views/pages2/update_record.dart';
import 'package:firebase_project_four/views/pages3/cloud_firestore.dart';
import 'package:firebase_project_four/views/pages3/cloud_firestore_two.dart';
import 'package:flutter/material.dart';

class FlutterImageUpload extends StatefulWidget {
  const FlutterImageUpload({Key? key}) : super(key: key);

  @override
  State<FlutterImageUpload> createState() => _FlutterImageUploadState();
}

class _FlutterImageUploadState extends State<FlutterImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widgetText("Realtime Database", Colors.orangeAccent, FontWeight.bold, 20.0),
              allButton(context,"Insert data", InsertData()),
              allButton(context,"Display data", DisplayData()),
              allButton(context,"Update data", UpdateData()),
              allButton(context,"Delete data", DeleteData()),
              const SizedBox(height: 30,),
              widgetText("Realtime Database", Colors.orangeAccent, FontWeight.bold, 20.0),
              allButton(context,"Insert record", InsertRecord()),
              allButton(context,"Display record", DisplayRecord()),
              allButton(context,"Update record", UpdateRecord()),
              allButton(context,"Delete record", DeleteRecord()),
              const SizedBox(height: 30,),
              widgetText("Firebase Other  Functions", Colors.orangeAccent, FontWeight.bold, 20.0),
              allButton(context,"Cloud Firestore", CloudFirestore()),
              allButton(context,"Cloud Firestore two", CloudFireStoreTwo()),
            ],
          ),
        ),
      ),
    );
  }
}
Widget allButton(BuildContext context,String txt,var pageName){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.orangeAccent,
      onPrimary: Colors.white
    ),
    onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>pageName));
  }, child: Text(txt),

  );
}
Widget widgetText(String txt,Color color,FontWeight fontWeight,double size){
  return Text(txt,style: TextStyle(fontSize: size,color: color,fontWeight: fontWeight),);
}
