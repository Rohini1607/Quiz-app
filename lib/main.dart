import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/story_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: StoryTimeBuddyApp(),
    ),
  );
}

class StoryTimeBuddyApp extends StatelessWidget {
  const StoryTimeBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoryTime Buddy',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const StoryScreen(),
    );
  }
}