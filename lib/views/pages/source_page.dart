import 'package:firebase_project_four/widgets/camera_button_widget.dart';
import 'package:firebase_project_four/widgets/gallery_button_widget.dart';
import 'package:flutter/material.dart';

class SourcePage extends StatelessWidget {
  const SourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Source Page"),
      ),
      body: ListView(
        children: const [
           CameraButtonWidget(),
           GalleryButtonWidget()
        ],
      ),
    );
  }
}
