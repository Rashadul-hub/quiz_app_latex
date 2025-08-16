import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_latex/services/local_store.dart';
import '../models/leaderboard_entry.dart';
import '../providers/quiz_provider.dart';
import '../widgets/latex_text.dart';
import '../widgets/option_tile.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    final quizPro = context.read<QuizProvider>();

    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: quizPro.perQuestionSeconds),
    );

    _progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_progressController)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    quizPro.startTimer(() {
      if (mounted) setState(() {});
    }, () => _onTimeout());

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    context.read<QuizProvider>().stopTimer();
    super.dispose();
  }

  void _onTimeout() {
    final quizPro = context.read<QuizProvider>();
    if (quizPro.selected == null) quizPro.select(-1);
     Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _nextQuestion();
    });
  }

  void _nextQuestion() {
    final quizPro = context.read<QuizProvider>();
    quizPro.stopTimer();

    if (quizPro.isLast) {
      LocalStore.addScore(LeaderboardEntry(
        'Player',
        quizPro.score,
        quizPro.total,
        DateTime.now(),
      ));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/results');
    } else {
      quizPro.next();
      quizPro.startTimer(() => setState(() {}), () => _onTimeout());
      _progressController.reset();
      _progressController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizPro = context.watch<QuizProvider>();
    final question = quizPro.current;
    final locked = quizPro.selected != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Q${quizPro.index + 1}/${quizPro.total}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('${quizPro.secondsLeft}s', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: _progressAnimation.value,
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).colorScheme.primary,
            minHeight: 6,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Question Card
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero)
                    .animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: offsetAnimation, child: child),
                );
              },
              child: Card(
                key: ValueKey(question.id),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: LatexText(
                      tex: question.question,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

            // Options List
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, i) => OptionTile(
                  label: question.options[i],
                  selected: quizPro.selected == i,
                  correct: i == question.answerIndex,
                  locked: locked,
                  onTap: () => quizPro.select(i),
                ),
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      quizPro.restart();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Quit', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: locked ? _nextQuestion : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(quizPro.isLast ? 'Finish' : 'Next', style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}