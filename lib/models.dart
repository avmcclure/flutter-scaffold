class Item {
  const Item({
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.description,
    this.facts = const {},
  });

  final String emoji;
  final String name;
  final String subtitle;
  final String description;

  /// Label → value pairs shown as chips on the detail page.
  final Map<String, String> facts;
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  final String question;
  final List<String> options;
  final int answerIndex;
}
