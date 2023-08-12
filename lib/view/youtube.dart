// ignore_for_file: camel_case_types, must_be_immutable

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Youtube_screen extends StatefulWidget {
  Youtube_screen({Key? key, required this.link}) : super(key: key);
  static const route = '/youtube';
  String link;
  @override
  State<Youtube_screen> createState() => _Youtube_screenState();
}

class _Youtube_screenState extends State<Youtube_screen> {
  late String videoURL;
  late YoutubePlayerController _controller;
  String? videoID;
  Video? _videoMetaData;
  Future<Video> fetchVideoMetadata(String videoUrl) async {
    final yt = YoutubeExplode();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    final video = await yt.videos.get(videoId);
    return video;
  }

  @override
  void initState() {
    videoURL = widget.link;
    _fetchVideoMetadata(videoURL);
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        showLiveFullscreenButton: true,
        controlsVisibleAtStart: true,
      ),
    );
    super.initState();
  }

  Future<void> _fetchVideoMetadata(String videoUrl) async {
    final video = await fetchVideoMetadata(videoUrl);
    setState(() {
      _videoMetaData = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
        ),
        body: Container(
          color: theme.disabledColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              SizedBox(height: size.height * 0.022), //16
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_videoMetaData != null) ...[
                          Text(
                            _videoMetaData!.title,
                            style: TextStyle(
                              fontSize: size.width * 0.050,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.009),
                          Text(
                            _videoMetaData!.author,
                            style: TextStyle(
                              fontSize: size.width * 0.040,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: size.height * 0.009),
                          Text(
                            "${_videoMetaData!.duration!.inMinutes.toString()}:00 Minutes",
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: size.height * 0.017),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(height: size.height * 0.020),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(height: size.height * 0.050),
                          SizedBox(
                            height: 200,
                            child: Center(
                                child: Opacity(
                              opacity: 0.8,
                              child: Image.asset(
                                'assets/icons/goku.gif',
                              ),
                            )),
                          )
                        ] else ...[
                          const Center(
                              child:
                                  CircularProgressIndicator()), // Show loading indicator
                        ],
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
