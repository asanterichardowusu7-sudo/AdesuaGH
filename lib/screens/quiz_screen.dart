import 'package:flutter/material.dart';
import '../services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quiz = QuizService();
  List<TriviaQuestion> _questions = [];
  bool _loading = true;
  int _index = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; });
    try {
      final q = await _quiz.fetchQuestions(amount: 5);
      setState(() { _questions = q; _index = 0; _score = 0; });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load quiz: $e')));
    } finally {
      setState(() { _loading = false; });
    }
  }

  void _answer(String selected) {
    if (_questions[_index].correct == selected) _score++;
    if (_index < _questions.length - 1) {
      setState(() => _index++);
    } else {
      // show result
      showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text('Quiz complete'),
        content: Text('Score: $_score / ${_questions.length}'),
        actions: [
          TextButton(onPressed: () { Navigator.pop(context); _load(); }, child: const Text('Retry')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final q = _questions[_index];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz - AdesuaGH')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Question ${_index + 1} / ${_questions.length}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(q.question, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            ...q.options.map((o) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(onPressed: () => _answer(o), child: Text(o)),
            )),
          ],
        ),
      ),
    );
  }
}
