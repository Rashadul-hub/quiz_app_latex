import 'package:flutter/material.dart';
import '../services/local_store.dart';
import '../models/leaderboard_entry.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = LocalStore.topScores(limit: 100);
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: items.isEmpty
          ? const Center(child: Text('No scores yet'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final LeaderboardEntry e = items[i];
          return ListTile(
            leading: CircleAvatar(child: Text('${i+1}')),
            title: Text(e.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('${e.createdAt.toLocal()}'),
            trailing: Text('${e.score}/${e.total}', style: Theme.of(context).textTheme.titleMedium),
          );
        },
        separatorBuilder: (_, __)=>const Divider(height: 1),
        itemCount: items.length,
      ),
    );
  }
}
