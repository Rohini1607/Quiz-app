import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tts_service.dart';

final audioProvider = Provider<TtsService>((ref) {
  return TtsService();
});