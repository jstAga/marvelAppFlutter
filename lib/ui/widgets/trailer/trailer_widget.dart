import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerWidget extends StatefulWidget {
  const TrailerWidget({required this.trailerKey, super.key});

  final String trailerKey;

  @override
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  late final _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
        controller: _controller, showVideoProgressIndicator: true);
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
            appBar: AppBar(title: const Text("Trailer")),
            body: Center(child: player));
      },
    );
  }
}
