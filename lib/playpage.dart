import 'package:flutter/material.dart';
import 'package:galaxy_music/homepage.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  final String songTitle;
  final String artistName;
  final String imagePath;
  final String audioPath;

  const MusicPlayer({
    Key? key,
    required this.songTitle,
    required this.artistName,
    required this.imagePath,
    required this.audioPath,
  }) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _audioInitError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() async {
  try {
    // Set audio source
    await _audioPlayer.setSource(AssetSource(widget.audioPath));

    // Tunggu sebentar untuk memastikan durasi dimuat
    await Future.delayed(const Duration(milliseconds: 500));

    // Ambil durasi lagu
    Duration? duration = await _audioPlayer.getDuration();
    
    if (duration != null) {
      setState(() {
        _duration = duration;
      });
    }

    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    // Auto play when initialized
    await _audioPlayer.resume();
  } catch (e) {
    print('Audio Initialization Error: $e');
    setState(() {
      _audioInitError = true;
      _errorMessage = e.toString();
    });
  }
}
  void _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  void _seekTo(double value) async {
    await _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                ),
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header: Image and Title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Favorit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text (
                                  'Private Favorit',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black38,
                          thickness: 1,
                          height: 20,
                        ),
                        // Actions
                        ListTile(
                          leading: const Icon(Icons.add, color: Colors.black),
                          title: const Text(
                            'Add to this Favorit',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          onTap: () {
                            // Handle action
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.edit, color: Colors.black),
                          title: const Text(
                            'Edit this Favorit',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          onTap: () {
                            // Handle action
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.black),
                          title: const Text(
                            'Delete this Favorit',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          onTap: () {
                            // Handle action
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.share, color: Colors.black),
                          title: const Text(
                            'Share this Favorit',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                          onTap: () {
                            // Handle action
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _audioInitError 
        ? _buildErrorView() 
        : _buildMusicPlayerView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline, 
            color: Colors.red, 
            size: 100
          ),
          const SizedBox(height: 20),
          Text(
            'Unable to Load Audio',
            style: TextStyle(
              color: Colors.white, 
              fontSize: 18, 
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _errorMessage,
            style: TextStyle(
              color: Colors.grey, 
              fontSize: 14
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Go Back'),
          )
        ],
      ),
    );
  }

  Widget _buildMusicPlayerView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album/Song Image
          Center(
  child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
),

          // Song Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.songTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.artistName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Progress Slider
          // Progress Slider
Slider(
  value: _position.inSeconds.toDouble(),
  min: 0,
  max: _duration.inSeconds > 0 
    ? _duration.inSeconds.toDouble() 
    : 0.0, // Gunakan 0.0 jika durasi belum tersedia
  onChanged: _duration.inSeconds > 0 
    ? (double value) {
        _seekTo(value);
      } 
    : null,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
),
// Progress Slider
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    children: [
      // Indikasi detik di bawah slider
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatDuration(_position),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            _formatDuration(_duration),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ],
  ),
),

          // Player Controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  iconSize: 48,
                  onPressed: () {
                    // Previous song logic
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, 
                    color: Colors.white,
                    size: 64,
                  ),
                  onPressed: _playPause,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  iconSize: 48,
                  onPressed: () {
                    // Next song logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

}