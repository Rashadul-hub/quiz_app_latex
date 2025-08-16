import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/leaderboard_entry.dart';
import '../services/local_store.dart';

class ResultsScreen extends StatefulWidget { const ResultsScreen({super.key}); @override State<ResultsScreen> createState()=>_ResultsScreenState(); }

class _ResultsScreenState extends State<ResultsScreen> {
  final _ctrl = TextEditingController(text: 'Player');
  bool _saved = false;

  Future<void> _save(int score, int total) async {
    if(_saved) return;
    await LocalStore.addScore(LeaderboardEntry(_ctrl.text.trim().isEmpty? 'Player' : _ctrl.text.trim(), score, total, DateTime.now()));
    setState(()=>_saved=true);
  }

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuizProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Your Score', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('${qp.score} / ${qp.total}', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 24),
            TextField(controller: _ctrl, decoration: const InputDecoration(labelText: 'Your name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: () async { await _save(qp.score, qp.total); if(mounted) Navigator.pushReplacementNamed(context, '/leaderboard'); }, icon: const Icon(Icons.save), label: Text(_saved? 'Saved' : 'Save to Leaderboard')),
            const Spacer(),
            OutlinedButton(onPressed: ()=>{qp.restart(), Navigator.pushReplacementNamed(context,'/')}, child: const Text('Back to Home')),
          ],
        ),
      ),
    );
  }
}
