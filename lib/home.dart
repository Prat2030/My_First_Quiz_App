// ignore_for_file: unused_import, prefer_const_declarations, unused_element, no_logic_in_create_state, prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_statements, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_final_fields, unused_field, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerSelected = false;
  bool quizEnd = false;
  bool answerCorrect = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // when an answer was tapped and selected
      answerSelected = true;
      // check if the answer is correct
      if (answerScore) {
        _totalScore++;
        answerCorrect = true;
      }
      // adding icons to the top of the screen
      _scoreTracker.add(answerScore
          ? Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : Icon(
              Icons.cancel,
              color: Colors.red,
            ));

      // When the quiz ends
      if (_questionIndex == _questions.length - 1) {
        quizEnd = true;
      }
    });
  }

  _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerSelected = false;
      answerCorrect = false;
    });

    // Reseting the quiz when the quiz ends ....
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      quizEnd = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker,
              ],
            ),
            Container(
              width: double.infinity,
              height: 130,
              margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['questionText'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answers: answer['text'].toString(),
                answerColor: answerSelected
                    ? (answer['score'] == true)
                        ? Colors.green.shade400
                        : Colors.red.shade500
                    : null,
                onTap: () {
                  // When an answer is already selected , then nothing should happen on tap.
                  if (answerSelected) {
                    return;
                  }

                  //when an answer is selected
                  _questionAnswered(answer['score'] == true);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                onPressed: () {
                  if (!answerSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an answer'),
                      ),
                    );
                    return;
                  }

                  _nextQuestion();
                },
                child: Text(quizEnd ? 'Restart Quiz' : 'Next Question')),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                  '${_totalScore.toString()}/${_questions.length.toString()}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            if (answerSelected && !quizEnd)
              Container(
                  height: 100,
                  width: double.infinity,
                  color: answerCorrect ? Colors.green : Colors.red,
                  child: Center(
                    child:
                        Text(answerCorrect ? 'Correct Answer' : 'Wrong Answer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                  )),
            if (quizEnd)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Quiz Ended',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'questionText': 'What\'s your favorite color?',
    'answers': [
      {'text': 'Black', 'score': true},
      {'text': 'Red', 'score': false},
      {'text': 'Green', 'score': false},
      {'text': 'White', 'score': false},
    ],
  },
  {
    'questionText': 'What\'s your favorite animal?',
    'answers': [
      {'text': 'Rabbit', 'score': false},
      {'text': 'Snake', 'score': false},
      {'text': 'Elephant', 'score': true},
      {'text': 'Lion', 'score': false},
    ],
  },
  {
    'questionText': 'Who\'s your favorite instructor?',
    'answers': [
      {'text': 'You', 'score': false},
      {'text': 'We', 'score': false},
      {'text': 'Me', 'score': false},
      {'text': 'None', 'score': true},
    ]
  },
];
