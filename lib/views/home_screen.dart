import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final questionPro = context.watch<QuizProvider>();
    final categories = questionPro.categories;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Quiz'), actions: [
        IconButton(icon: const Icon(Icons.dark_mode), onPressed: ()=>context.read<ThemeProvider>().toggle()),
        IconButton(icon: const Icon(Icons.leaderboard), onPressed: ()=>Navigator.pushNamed(context, '/leaderboard')),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              value: questionPro.category,
              items: categories.map((c)=>DropdownMenuItem(value:c, child: Text(c))).toList(),
              onChanged: (v)=>context.read<QuizProvider>().setCategory(v!),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: ()=>Navigator.pushNamed(context, '/quiz'),
              icon: const Icon(Icons.play_arrow), label: const Text('Start Quiz'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: ()=>Navigator.pushNamed(context, '/leaderboard'),
              icon: const Icon(Icons.emoji_events_outlined), label: const Text('Leaderboard'),
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
