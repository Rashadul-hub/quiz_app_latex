import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_latex/services/local_store.dart';
import 'package:quiz_app_latex/views/home_screen.dart';
import 'package:quiz_app_latex/views/leaderboard_screen.dart';
import 'package:quiz_app_latex/views/results_screen.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'views/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await LocalStore.init();
  final questions = await LocalStore.loadQuestions();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => QuizProvider(questions)),
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final baseLight = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.indigo,
    );
    final baseDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.indigo,
    );


    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: baseLight,
      darkTheme: baseDark,
      themeMode: theme.mode,
      routes: {
        '/': (_) => const HomeScreen(),
        '/quiz': (_) => const QuizScreen(),
        '/results': (_) => const ResultsScreen(),
        '/leaderboard': (_) => const LeaderboardScreen(),
      },
     );
  }
}

