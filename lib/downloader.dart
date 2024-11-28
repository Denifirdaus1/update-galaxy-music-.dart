import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class Downloader extends StatefulWidget {
  const Downloader({super.key});
  @override
  _DownloaderState createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String _status = '';
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String? extractVideoId(String url) {
    final RegExp regex = RegExp(
        r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  Future<void> downloadAudio(String url) async {
    setState(() {
      _isLoading = true;
      _status = 'Mengunduh...';
    });

    try {
      // Meminta izin penyimpanan, tetapi tetap lanjutkan meski ditolak
      var permissionStatus = await Permission.storage.request();

      var yt = YoutubeExplode();
      var videoId = extractVideoId(url);
      if (videoId == null) {
        setState(() {
          _status = 'URL tidak valid';
          _isLoading = false;
        });
        return;
      }

      var video = await yt.videos.get(videoId);
      var manifest = await yt.videos.streamsClient.getManifest(video.id);
      var audioStream = manifest.audioOnly.first;

      // Tetapkan lokasi penyimpanan di folder Downloads
      Directory downloadsDirectory = Directory('/storage/emulated/0/Download');
      if (!downloadsDirectory.existsSync()) {
        downloadsDirectory.createSync(recursive: true);
      }

      final filePath = '${downloadsDirectory.path}/${video.title}.mp3';

      // Unduh audio
      var audioFile = File(filePath);
      var response = yt.videos.streamsClient.get(audioStream);

      var fileSink = audioFile.openWrite();
      await for (var chunk in response) {
        fileSink.add(chunk);
      }
      await fileSink.close();

      setState(() {
        _status = 'Unduhan selesai: ${video.title}.mp3';
      });
    } catch (e) {
      setState(() {
        _status = 'Gagal mengunduh: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube MP3 Downloader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Masukkan URL YouTube',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 81, 71, 71),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      final url = _controller.text;
                      downloadAudio(url);
                    },
              child: const Text('Unduh MP3'),
            ),
            const SizedBox(height: 20),
            if (_status.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 67, 67),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _status,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            if (_isLoading)
              RotationTransition(
                turns: _animationController,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/imgbg/logo nb 3.png'), // Custom logo
                ),
              ),
          ],
        ),
      ),
    );
  }
}
