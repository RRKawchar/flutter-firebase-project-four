import 'dart:io';

import 'package:firebase_project_four/model/media_source.dart';
import 'package:firebase_project_four/widgets/listTile_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryButtonWidget extends StatelessWidget {
  const GalleryButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      txt: "From Gallery",
      icon: Icons.photo,
      onClicked: () => pickGalleryMedia(context),
    );
  }

  Future pickGalleryMedia(BuildContext context) async {
    final MediaSource source =
        ModalRoute.of(context)!.settings.arguments as MediaSource;

    final getMedia=source == MediaSource.image
        ? ImagePicker().pickImage
        : ImagePicker().pickVideo;

   final media=await getMedia(source: ImageSource.gallery);
   final file=File(media!.path);
   Navigator.of(context).pop(file);
  }
}
