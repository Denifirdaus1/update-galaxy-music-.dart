import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloader extends StatefulWidget {
  const Downloader({super.key});
  @override
  _DownloaderState createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  final TextEditingController _controller = TextEditingController();
  String _status = '';

  String? extractVideoId(String url) {
    final RegExp regex = RegExp(
        r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      setState(() {
        _status = 'Izin penyimpanan ditolak';
      });
    } else if (status.isPermanentlyDenied) {
      // Jika izin ditolak secara permanen, arahkan pengguna ke pengaturan
      openAppSettings();
    }
  }

  Future<void> downloadAudio(String url) async {
    try {
      // Meminta izin untuk mengakses penyimpanan
      await requestStoragePermission();

      var yt = YoutubeExplode();
      var videoId = extractVideoId(url);
      if (videoId == null) {
        setState(() {
          _status = 'URL tidak valid';
        });
        return;
      }

      var video = await yt.videos.get(videoId);
      var manifest = await yt.videos.streamsClient.getManifest(video.id);
      var audioStream = manifest.audioOnly.first;

      // Mendapatkan path direktori Downloads
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      final filePath = '${downloadsDirectory!.path}/${video.title}.mp3';

      // Unduh audio
      var audioFile = File(filePath);
      var response = yt.videos.streamsClient.get(audioStream);

      // Menulis stream ke file
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
              decoration: const InputDecoration(hintText: 'Masukkan URL YouTube'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final url = _controller.text;
                downloadAudio(url);
              },
              child: const Text('Unduh MP3'),
            ),
            const SizedBox(height: 20),
            Text(_status),
          ],
        ),
      ),
    );
  }
}