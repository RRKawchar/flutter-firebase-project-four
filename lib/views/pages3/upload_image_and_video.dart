import 'dart:io';

import 'package:firebase_project_four/widgets/custom_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudFireStoreFour extends StatefulWidget {
  const CloudFireStoreFour({Key? key}) : super(key: key);

  @override
  State<CloudFireStoreFour> createState() => _CloudFireStoreFourState();
}

class _CloudFireStoreFourState extends State<CloudFireStoreFour> {
  final ImagePicker _picker = ImagePicker();
  String title = "Upload Image and Video";
  XFile? _filename;
  String imagePath = "";
  String filePath = "";
  String uploadPath = "";
  FirebaseStorage storageRef = FirebaseStorage.instance;
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Camera",
                icon: Icons.camera,
                onclicked: selectedCamera,
                fontWeight: FontWeight.normal,
                size: 30,
                color: Colors.white,
              ),
              CustomButton(
                text: "Select Image",
                icon: Icons.image,
                onclicked: selectedImage,
                fontWeight: FontWeight.normal,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                imagePath,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              // CustomButton(
              //   text: "Upload Image",
              //   icon: Icons.cloud_upload,
              //   onclicked: () {
              //     uploadImage(_filename!);
              //   },
              //   fontWeight: FontWeight.normal,
              //   size: 30.0,
              //   color: Colors.white,
              // ),
              OutlinedButton.icon(
                onPressed: () {
                  uploadImagTwo(_filename!);
                },
                icon: const Icon(Icons.cloud_upload),
                label: const Text("Upload"),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Part two",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: "Select file",
                icon: Icons.attach_file,
                onclicked: () {},
                fontWeight: FontWeight.normal,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                filePath,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: "Upload file",
                icon: Icons.upload_outlined,
                onclicked: () {},
                fontWeight: FontWeight.normal,
                size: 30.0,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }



  Future selectedImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _filename = img;
      imagePath = img!.name.toString();
    });
  }

  Future selectedCamera() async {
    final img = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _filename = img;
      imagePath = img!.name.toString();
    });
  }
  Future<void> uploadImagTwo(XFile file) async {
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
    storageRef.ref().child("images3").child("user3").child(uploadFileName);

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
  Future<void> uploadImage(XFile file) async {
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
        storageRef.ref().child("iamges2").child("user3").child(uploadFileName);

    UploadTask uploadTask = reference.putFile(File(file.name));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isloading=true;
      });
    });

    await uploadTask.whenComplete(() async {
      uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {

        _isloading=false;
      });
    });
  }
}
