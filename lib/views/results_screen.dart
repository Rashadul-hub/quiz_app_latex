import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/leaderboard_entry.dart';
import '../services/local_store.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState()=>_ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with SingleTickerProviderStateMixin {
  final _ctrl = TextEditingController(text: 'Player');
  bool _saved = false;
  late AnimationController _animController;

  Future<void> _save(int score, int total) async {
    if (_saved) return;
    await LocalStore.addScore(
      LeaderboardEntry(
        _ctrl.text.trim().isEmpty ? 'Player' : _ctrl.text.trim(),
        score,
        total,
        DateTime.now(),
      ),
    );
    setState(() => _saved = true);
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizPro = context.watch<QuizProvider>();
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          children: [
            // Animated Score Card
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                final value = _animController.value;
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 40),
                    child: child,
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.04,
                    horizontal: screenWidth * 0.06,
                  ),
                  child: Column(
                    children: [
                      Text('Your Score',
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: screenHeight * 0.02),
                      Text('${quizPro.score} / ${quizPro.total}',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Animated Name Input
            FadeTransition(
              opacity: _animController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: _animController, curve: Curves.easeOut)),
                child: TextField(
                  controller: _ctrl,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Save Button
            FadeTransition(
              opacity: _animController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: _animController, curve: Curves.easeOut)),
                child: FilledButton.icon(
                  onPressed: () async {
                    await _save(quizPro.score, quizPro.total);
                    if (mounted) {
                      quizPro.restart();
                      Navigator.pushReplacementNamed(context, '/leaderboard');
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: Text(_saved ? 'Saved' : 'Save to Leaderboard'),
                  style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015,horizontal: screenWidth * 0.1)),
                ),
              ),
            ),

            const Spacer(),

            // Back to Home
            FadeTransition(
              opacity: _animController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: _animController, curve: Curves.easeOut)),
                child: OutlinedButton.icon(
                  onPressed: () {
                    quizPro.restart();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Back to Home'),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015,horizontal: screenWidth * 0.1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}