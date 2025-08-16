import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/leaderboard_entry.dart';
import '../models/question.dart';

class LocalStore {
  static const _boxScores = 'leaderboard';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LeaderboardEntryAdapter());
    await Hive.openBox<LeaderboardEntry>(_boxScores);
  }
  static Future<List<Question>> loadQuestions() async => (jsonDecode(await rootBundle.loadString('assets/questions.json')) as List).map((e)=>Question.fromJson(e)).toList();

  static Box<LeaderboardEntry> get _scores => Hive.box<LeaderboardEntry>(_boxScores);

  static Future<void> addScore(LeaderboardEntry e) async => _scores.add(e);

  static List<LeaderboardEntry> topScores({int limit = 100}) => _scores.values.toList()..sort((a,b)=>b.score.compareTo(a.score))..length=( (_scores.values.length<limit)?_scores.values.length:limit );
}