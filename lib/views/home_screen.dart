// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/quiz_provider.dart';
// import '../providers/theme_provider.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final questionPro = context.watch<QuizProvider>();
//     final categories = questionPro.categories;
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Quiz App'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.dark_mode),
//             onPressed: ()=>context.read<ThemeProvider>().toggle(),
//           ),
//           IconButton(
//             icon: const Icon(Icons.leaderboard),
//             onPressed: ()=>Navigator.pushNamed(context, '/leaderboard'),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Category',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 filled: true,
//                 fillColor: Theme.of(context).colorScheme.surfaceVariant,
//               ),
//               value: questionPro.category,
//               items: categories.map((c) =>
//                   DropdownMenuItem(value: c, child: Text(c))).toList(),
//               onChanged: (v)=>context.read<QuizProvider>().setCategory(v!),
//             ),
//
//             Image.asset(
//               'assets/images/quizImg.png',
//               fit: BoxFit.contain,
//               filterQuality: FilterQuality.medium,
//             ),
//
//             const Spacer(),
//             FilledButton.icon(
//               onPressed: ()=>Navigator.pushNamed(context, '/quiz'),
//               icon: const Icon(Icons.play_arrow),
//               label: const Text('Start Quiz'),
//               style: FilledButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//             ),
//             const SizedBox(height: 12),
//             OutlinedButton.icon(
//               onPressed: ()=>Navigator.pushNamed(context, '/leaderboard'),
//               icon: const Icon(Icons.emoji_events_outlined),
//               label: const Text('Leaderboard'),
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 18),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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

    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive paddings and heights
    final horizontalPadding = screenWidth * 0.05;
    final imageHeight = screenHeight * 0.3;
    final spacingSmall = screenHeight * 0.02;
    final spacingMedium = screenHeight * 0.07;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => context.read<ThemeProvider>().toggle(),
          ),
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: spacingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Selector
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
              value: questionPro.category,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => context.read<QuizProvider>().setCategory(v!),
            ),
            SizedBox(height: spacingMedium),

            // Quiz Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/quizImg.png',
                fit: BoxFit.contain,
                height: imageHeight,
              ),
            ),
            SizedBox(height: spacingSmall),

            // Description Text
            const Text(
              'Test your knowledge in math and science!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: spacingMedium),

            // Start Quiz Button
            FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Quiz'),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: spacingSmall * 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: spacingSmall * 2),

            // Leaderboard Button
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
              icon: const Icon(Icons.emoji_events_outlined),
              label: const Text('Leaderboard'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: spacingSmall * 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

