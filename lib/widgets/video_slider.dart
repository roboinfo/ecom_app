import 'dart:convert';
import 'package:ecom_app/services/video_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSlider extends StatefulWidget {
  @override
  _VideoSliderState createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  VideoService _videoService = VideoService();
  final List<String> items = [];

  @override
  void initState() {
    super.initState();
    _getAllVideos();
  }

  _getAllVideos() async {
    var videos = await _videoService.getVideos();
    var result = json.decode(videos.body);
    result['data'].forEach((data) {
      setState(() {
        items.add(data['video'].toString());
      });
    });
    //print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
       height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: VideoPlayerWidget(
                videoUrl: items[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl}) : super();

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  double _videoPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoController!.initialize().then((_) {
      setState(() {});
    });
    _videoController!.setLooping(true);
    _isPlaying = false;

    _videoController!.addListener(() {
      setState(() {
        _videoPosition = _videoController!.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
        _isPlaying = false;
      } else {
        _videoController!.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final videoDuration = _videoController!.value.duration;

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          if (!_isPlaying)
            Icon(
              Icons.play_arrow,
              size: 80,
              color: Colors.white,
            ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: [
                Text(
                  '${_videoPosition ~/ 60}:${(_videoPosition % 60).toInt().toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 8),
                Slider(
                  value: _videoPosition,
                  min: 0.0,
                  max: videoDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _videoPosition = value;
                      final newPosition = Duration(seconds: value.toInt());
                      _videoController!.seekTo(newPosition);
                    });
                  },
                ),
                SizedBox(width: 8),
                Text(
                  '${videoDuration.inMinutes}:${(videoDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
