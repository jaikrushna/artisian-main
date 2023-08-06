import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class Youtube_screen extends StatefulWidget {
  const Youtube_screen({Key? key}) : super(key: key);
  static const route = '/youtube';

  @override
  State<Youtube_screen> createState() => _Youtube_screenState();
}

class _Youtube_screenState extends State<Youtube_screen> {
  final videoURL = "https://www.youtube.com/watch?v=n0ciQf4HDxg";
  late YoutubePlayerController _controller;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) => Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _controller.metadata.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _controller.metadata.author,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${_controller.metadata.duration.inMinutes.toString()}:00 Minutes",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 200,
                    child: Center(
                        child: Opacity(
                      opacity: 0.8,
                      child: Image.asset(
                        'assets/icons/goku.gif',
                      ),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
