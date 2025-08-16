class Question {
  final int id;
  final String category;
  final String question;
  final List<String> options;
  final int answerIndex;

  const Question({required this.id, required this.category, required this.question, required this.options, required this.answerIndex});

  factory Question.fromJson(Map<String, dynamic> j) => Question(
    id: j['id'] as int,
    category: j['category'] as String? ?? 'General',
    question: j['question'] as String,
    options: (j['options'] as List).cast<String>(),
    answerIndex: j['answer_index'] as int,
  );
}
