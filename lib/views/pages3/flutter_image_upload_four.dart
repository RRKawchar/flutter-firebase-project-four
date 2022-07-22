import 'package:firebase_project_four/widgets/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FlutterImageUploadFour extends StatefulWidget {
  const FlutterImageUploadFour({Key? key}) : super(key: key);

  @override
  State<FlutterImageUploadFour> createState() => _FlutterImageUploadFourState();
}

class _FlutterImageUploadFourState extends State<FlutterImageUploadFour> {
  XFile? _filename;
   ImagePicker _picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Image Upload"),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButtonTwo(icon: Icons.image, text: "Select Image", onclicked: selectedImage),
            Text("No File Selected"),
            CustomButtonTwo(icon: Icons.cloud_upload, text: "Upload Images", onclicked: uploadImage)
          ],
        ),
      ) ,
    );
  }
  Future<void> selectedImage()async{
    _filename=await _picker.pickImage(source: ImageSource.gallery);
  }
  Future<void> uploadImage()async{

  }
}
