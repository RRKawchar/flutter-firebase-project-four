import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudFireStoreTwo extends StatefulWidget {
  const CloudFireStoreTwo({Key? key}) : super(key: key);

  @override
  State<CloudFireStoreTwo> createState() => _CloudFireStoreTwoState();
}

class _CloudFireStoreTwoState extends State<CloudFireStoreTwo> {
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  String selectedFileName = "";
  String uploadPath = "";
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _isloading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        selectedImage();
                      },
                      child: const Text("Selected File"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    selectedFileName == ""
                        ? Container()
                        : Text("File Name: $selectedFileName"),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {
                          UploadImage(_selectedFile!);
                        },
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text("Upload")),
                    const SizedBox(
                      height: 50,
                    ),
                    uploadPath == ""
                        ? Container()
                        : Image(
                            image: NetworkImage(uploadPath),
                          )
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> UploadImage(XFile file) async {
    FirebaseStorage storageRef = FirebaseStorage.instance;
    String uploadFileName=DateTime.now().millisecondsSinceEpoch.toString()+".jpg";
    Reference reference =
        storageRef.ref().child("uploadImage").child("personal").child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(file.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isloading = true;
      });
    });
    await uploadTask.whenComplete(() async {
      uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadPath);
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<void> selectedImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = img;
      selectedFileName = img!.name.toString();
    });
  }
}
