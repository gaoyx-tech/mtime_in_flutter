import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayPreviewPage extends StatefulWidget {
  final String sPlayUrl;
  final String sPlayTitle;

  PlayPreviewPage({Key key, this.sPlayTitle, this.sPlayUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlayPreviewState();
  }
}

class PlayPreviewState extends State<PlayPreviewPage> {
  ChewieController _chewieController;
  VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    //
    _playerController = VideoPlayerController.network(widget.sPlayUrl);
    _chewieController = ChewieController(
        videoPlayerController: _playerController,
        autoPlay: true,
        autoInitialize: true,
        aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    //进入全屏会call ，所以加次判断
    if (!_chewieController.isFullScreen) {
      _chewieController.pause();
      _playerController.dispose();
      _chewieController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.sPlayTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400)),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: Column(children: <Widget>[
          Expanded(child: Center(child: Chewie(controller: _chewieController)))
        ]));
  }
}
