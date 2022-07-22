import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudFirestore extends StatefulWidget {
  const CloudFirestore({Key? key}) : super(key: key);

  @override
  State<CloudFirestore> createState() => _CloudFirestoreState();
}

class _CloudFirestoreState extends State<CloudFirestore> {
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  String selectedFilName = "";
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String uploadedPath = "";
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isloading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.orangeAccent),
                      onPressed: () {
                        funSelectedImage();
                      },
                      child: const Text("Select  Image")),
                  const SizedBox(
                    height: 15,
                  ),
                  selectedFilName == ""
                      ? Container()
                      : Text("File Name :" + selectedFilName),
                  const SizedBox(
                    height: 15,
                  ),
                  OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.orangeAccent),
                      onPressed: () {
                        uploadImage(_selectedFile!);
                      },
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text("Upload")),
                  const SizedBox(height: 50,),
                   uploadedPath==""? Container():Image(image: NetworkImage(uploadedPath),)
                ],
              ),
      ),
    );
  }

  Future<void> uploadImage(XFile file) async {
    String uploadFileName = DateTime.now().millisecondsSinceEpoch.toString()+ '.jpg';
    Reference reference =
        storageRef.ref().child("profilePic").child("user1").child(uploadFileName);

    UploadTask uploadTask = reference.putFile(File(file.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isloading = true;
      });
    });
    await uploadTask.whenComplete(() async {
      uploadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadedPath);
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<void> funSelectedImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = img;
      selectedFilName = img!.name.toString();
    });
  }
}
