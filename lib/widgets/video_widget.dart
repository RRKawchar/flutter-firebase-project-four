import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final File file;
  const VideoWidget(this.file);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  Widget? videoStatusAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoStatusAnimation = Container();
    _controller = VideoPlayerController.file(widget.file)
      ..addListener(() {
        final bool isPlaying = _controller!.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        Timer(Duration(milliseconds: 0), () {
          if (!mounted) return;
          setState(() {});
          _controller!.play();
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _controller!.value.isInitialized? videoPlayer() :Container(),
    );
  }
  Widget videoPlayer(){
    return Stack(
      children: [
        video(),
        Align(
          alignment: Alignment.bottomCenter,
          child: VideoProgressIndicator(
            _controller!,
            allowScrubbing: true,
            padding:const EdgeInsets.all(16.0),
          ),
        ),
         Center(
           child: videoStatusAnimation,
         )
      ],
    );
  }
  Widget video(){
    return GestureDetector(
    child: VideoPlayer(_controller!),
      onTap: (){
      if(_controller!.value.isInitialized){
        return;
      }
      if(_controller!.value.isPlaying){
        videoStatusAnimation=FadeAnimation(
          child: Icon(Icons.pause,size: 100.0,),
        );
        _controller!.pause();
      }else{
        videoStatusAnimation=FadeAnimation(child: Icon(Icons.play_arrow,size: 100.0,));
        _controller!.play();
      }
      },
    );
  }
}
class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const FadeAnimation({required this.child,this.duration=const Duration(milliseconds: 1000)});

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
  with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(duration: widget.duration,vsync: this);
    animationController.addListener(() {
      if(mounted){
        setState((){});
      }
    });
    animationController.forward(from: 0.0);
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    animationController.stop();
    super.deactivate();
  }
  @override
  void didUpdateWidget(covariant FadeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.child!=widget.child){
    animationController.forward(from: 0.0);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating ?
        Opacity(opacity: 1.0-animationController.value,
        child: widget.child,
        ):Container();
  }
}
