import 'package:hive/hive.dart';
part 'leaderboard_entry.g.dart';

@HiveType(typeId: 1)
class LeaderboardEntry extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int score;
  @HiveField(2)
  final int total;
  @HiveField(3)
  final DateTime createdAt;

  LeaderboardEntry(this.name, this.score, this.total, this.createdAt);
}
