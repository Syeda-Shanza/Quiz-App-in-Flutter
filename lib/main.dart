import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Quiz App',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What programming language is this app built with?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'Python', 'score': 0},
        {'text': 'Dart', 'score': 1},
        {'text': 'C++', 'score': 0},
      ],
    },
    {
      'questionText': 'What does IDE stand for?',
      'answers': [
        {'text': 'Integrated Development Environment', 'score': 1},
        {'text': 'Interactive Design Environment', 'score': 0},
        {'text': 'Intelligent Development Engine', 'score': 0},
        {'text': 'Integrated Design Environment', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the purpose of the "git" version control system?',
      'answers': [
        {'text': 'To write code faster', 'score': 0},
        {'text': 'To manage and track changes in source code', 'score': 1},
        {'text': 'To create graphical user interfaces', 'score': 0},
        {'text': 'To design databases', 'score': 0},
      ],
    },
    {
      'questionText': 'Which data structure uses LIFO order?',
      'answers': [
        {'text': 'Queue', 'score': 0},
        {'text': 'Heap', 'score': 0},
        {'text': 'Stack', 'score': 1},
        {'text': 'Linked List', 'score': 0},
      ],
    },
    {
      'questionText': 'What does API stand for?',
      'answers': [
        {'text': 'Application Programming Interface', 'score': 1},
        {'text': 'Advanced Programming Interface', 'score': 0},
        {'text': 'Automated Programming Interface', 'score': 0},
        {'text': 'Application Process Interface', 'score': 0},
      ],
    },
    {
      'questionText': 'Which of the following is a statically-typed programming language?',
      'answers': [
        {'text': 'JavaScript', 'score': 0},
        {'text': 'Python', 'score': 0},
        {'text': 'Java', 'score': 1},
        {'text': 'Ruby', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the purpose of the "else" keyword in programming?',
      'answers': [
        {'text': 'To start a new block of code', 'score': 0},
        {'text': 'To define conditions', 'score': 0},
        {'text': 'To specify code to be executed when a condition is false', 'score': 1},
        {'text': 'To create a loop', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the primary use of the "map" function in Python?',
      'answers': [
        {'text': 'To filter elements of a list', 'score': 0},
        {'text': 'To perform a specific operation on each element of a list', 'score': 1},
        {'text': 'To create a new list with transformed elements', 'score': 0},
        {'text': 'To remove duplicates from a list', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the purpose of the "this" keyword in JavaScript?',
      'answers': [
        {'text': 'To refer to the current instance of a class', 'score': 1},
        {'text': 'To create a loop', 'score': 0},
        {'text': 'To define a new variable', 'score': 0},
        {'text': 'To declare a function', 'score': 0},
      ],
    },
    {
      'questionText': 'In object-oriented programming, what is encapsulation?',
      'answers': [
        {'text': 'Hiding the implementation details and exposing only the interface', 'score': 1},
        {'text': 'Using loops to iterate over a list', 'score': 0},
        {'text': 'Creating a new instance of a class', 'score': 0},
        {'text': 'Storing data in a table', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
        questionIndex: _questionIndex,
        questions: _questions,
        answerQuestion: _answerQuestion,
      )
          : Result(_score),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'].toString()),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score'] as int), answer['text'].toString());
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => selectHandler(),
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;

  Result(this.score);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score',
            style: TextStyle(fontSize: 24),
          ),
          // You can add more content or actions based on the user's score
        ],
      ),
    );
  }
}
