import 'package:flutter/material.dart';
import 'package:galaxy_music/Welcome_page.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:galaxy_music/percobaan_database.dart';
import 'package:galaxy_music/homepage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const GalaxyMusicApp(),
    ),
  );
}

class GalaxyMusicApp extends StatelessWidget {
  const GalaxyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Galaxy Music',
          theme: themeProvider.theme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
