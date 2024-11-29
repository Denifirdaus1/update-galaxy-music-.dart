import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class music extends StatefulWidget {
  const music({super.key});
  @override
  _MusicPlayerWidgetState createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<music> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;  
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listener untuk durasi lagu
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    // Listener untuk posisi lagu
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
  }

  // Fungsi untuk memainkan musik
  void _playMusic() async {
    await _audioPlayer.play(AssetSource('music/skyfall.mp3'));
    setState(() {
      _isPlaying = true;
    });
  }

  // Fungsi untuk menjeda musik
  void _pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  // Fungsi untuk melanjutkan musik
  void _resumeMusic() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  // Fungsi untuk mengatur posisi musik
  void _seekMusic(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Slider untuk mengontrol posisi musik
          Slider(
            value: _position.inSeconds.toDouble(),
            max: _duration.inSeconds.toDouble(),
            onChanged: (value) {
              _seekMusic(Duration(seconds: value.toInt()));
            },
          ),

          // Tampilan waktu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position)),
              Text(_formatDuration(_duration)),
            ],
          ),

          // Kontrol musik
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {
                  _seekMusic(_position - Duration(seconds: 10));
                },
              ),
              IconButton(
                icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                onPressed: () {
                  _isPlaying ? _pauseMusic() : _playMusic();
                },
              ),
              IconButton(
                icon: Icon(Icons.forward_10),
                onPressed: () {
                  _seekMusic(_position + Duration(seconds: 10));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memformat durasi
  String _formatDuration(Duration duration) {
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
