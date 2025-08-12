import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  // Example: fetch 5 general knowledge multiple-choice questions
  Future<List<TriviaQuestion>> fetchQuestions({int amount = 5}) async {
    final url = Uri.parse('https://opentdb.com/api.php?amount=$amount&type=multiple');
    final res = await http.get(url);
    if (res.statusCode != 200) throw Exception('Failed to load trivia');
    final data = jsonDecode(res.body);
    final results = data['results'] as List<dynamic>;
    return results.map((e) => TriviaQuestion.fromMap(e)).toList();
  }
}

class TriviaQuestion {
  final String question;
  final String correct;
  final List<String> options;

  TriviaQuestion({required this.question, required this.correct, required this.options});

  factory TriviaQuestion.fromMap(Map<String, dynamic> m) {
    final correct = m['correct_answer'] as String;
    final incorrect = List<String>.from(m['incorrect_answers'] as List);
    final options = List<String>.from(incorrect)..add(correct);
    options.shuffle();
    return TriviaQuestion(
      question: htmlDecode(m['question'] as String),
      correct: htmlDecode(correct),
      options: options.map(htmlDecode).toList(),
    );
  }
}

String htmlDecode(String s) {
  // basic decode for common HTML-entities returned by OpenTDB
  return s.replaceAll('&quot;', '"').replaceAll('&#039;', "'").replaceAll('&amp;', '&');
}
