import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/story_model.dart';

class JsonService {
  Future<List<StoryModel>> loadStories() async {
    final jsonString =
        await rootBundle.loadString(
      '/json/story.json',
    );

    final List<dynamic> data =
        jsonDecode(jsonString);

    return data
        .map((e) => StoryModel.fromJson(e))
        .toList();
  }
}