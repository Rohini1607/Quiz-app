import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts tts = FlutterTts();

  Future<void> speak(String text) async {
    await tts.stop();

    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.45);

    await tts.speak(text);
  }
}