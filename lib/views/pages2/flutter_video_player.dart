import 'dart:io';

import 'package:firebase_project_four/model/media_source.dart';
import 'package:firebase_project_four/views/pages/source_page.dart';
import 'package:firebase_project_four/widgets/video_widget.dart';
import 'package:flutter/material.dart';

class FlutterVideoPlayer extends StatefulWidget {
  const FlutterVideoPlayer({Key? key}) : super(key: key);

  @override
  State<FlutterVideoPlayer> createState() => _FlutterVideoPlayerState();
}

class _FlutterVideoPlayerState extends State<FlutterVideoPlayer> {
   File? fileMedia;
    MediaSource? source;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: fileMedia == null
                  ? Icon(
                      Icons.photo,
                      size: 120,
                    )
                  :(source==MediaSource.image ? Image.file(fileMedia!):VideoWidget(fileMedia!)),
            ),
            const SizedBox(height: 12,),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                capture(MediaSource.image);
              },
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: const Text("Capture image"),
            ),
            const SizedBox(
              height: 12,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                capture(MediaSource.video);
              },
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: const Text("Capture Video"),
            ),
          ],
        ),
      ),
    );
  }

  Future capture(MediaSource source) async {

    setState((){
      this.source=source;
      this.fileMedia=null;
    });
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SourcePage(),
          settings: RouteSettings(arguments: source)),
    );
    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
