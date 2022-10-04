import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      })
      ..addListener(() => setState(() {}))
      ..setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController))
                : const CircularProgressIndicator(color: Colors.black45,),
            VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: false,
              colors: const VideoProgressColors(
                  backgroundColor: Colors.black45,
                  bufferedColor: Colors.black45,
                  playedColor: Colors.blueAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                      fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)))),
                  onPressed: () {
                    setState(() {
                      _videoPlayerController.seekTo(const Duration(
                          seconds: 0));
                      _videoPlayerController.pause();

                    });
                  },
                  child: const Icon(Icons.square,size: 17,)),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)))),
                    onPressed: () {
                      setState(() {
                        // If the video is playing, pause it.
                        if (_videoPlayerController.value.isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          // If the video is paused, play it.
                          _videoPlayerController.play();
                        }
                      });
                    },
                    child: Icon(_videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow)),
                const SizedBox(
                  width: 20,
                ),

                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)))),
                    onPressed: () {
                      _videoPlayerController.seekTo(Duration(
                          seconds:
                              _videoPlayerController.value.position.inSeconds +
                                  10));
                    },
                    child: const Icon(Icons.forward_10)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
