import 'dart:io';

import 'package:firebase_project_four/model/firebase_api.dart';
import 'package:firebase_project_four/widgets/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class FirebaseUploadVideo extends StatefulWidget {
  const FirebaseUploadVideo({Key? key}) : super(key: key);

  @override
  State<FirebaseUploadVideo> createState() => _FirebaseUploadVideoState();
}

class _FirebaseUploadVideoState extends State<FirebaseUploadVideo> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    final fileName=file != null? basename(file!.path):"No file Selected";
    return Scaffold(
      appBar: AppBar(
        title: Text("image and video"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(icon: Icons.attach_file, text: "Select File", onclicked: selectedFile),
           const SizedBox(height: 8,),
           Text(fileName,
           ),
           const SizedBox(height: 20,),
            ButtonWidget(icon: Icons.cloud_upload, text: "Upload", onclicked: uploadFile),
            const SizedBox(height: 20,),
            task !=null?buildUploadStatus(task!):Container(),
          ],
        ),
      ),
    );
  }
  Future selectedFile()async{
  final result=await FilePicker.platform.pickFiles(allowMultiple: false);
  if(result==null) return;
  final path=result.files.single.path!;
  setState((){
    file=File(path);
  });
  }
 Future uploadFile()async{
   if(file==null) return ;
   final fileName=basename(file!.path);
   final destination="files/$fileName";
   
  task=FirebaseApi.uploadFile(destination, file!);

  if(task==null)return;
  final snapshot = await task!.whenComplete(() {});
  final urlDownload=await snapshot.ref.getDownloadURL();

  print("Download-link: $urlDownload");
   
 }

 Widget buildUploadStatus(UploadTask task){
    return StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,

        builder:(context,snapshot){
          if(snapshot.hasData){
          final snap=snapshot.data!;
            final progress=snap.bytesTransferred/snap.totalBytes;

             final percentage=(progress*100).toStringAsFixed(2);
            return Text(
              "$percentage %",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            );
          }else{
            return Container();
          }
        }
    );
 }
}
