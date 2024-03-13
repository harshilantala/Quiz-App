import 'package:flutter/material.dart';
import 'dart:async';
import 'quiz_question.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  List<int?> selectedOptions = [];
  PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;
  int questionTimerSeconds = 10; // Initial timer duration

  @override
  void initState() {
    super.initState();
    selectedOptions = List<int?>.filled(widget.questions.length, null);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Screen'),
      ),
      backgroundColor: Color(0xFF5170FD),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.questions[currentIndex].question,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: _buildOptions(widget.questions[currentIndex].options, widget.questions[currentIndex].correctOption),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '$questionTimerSeconds seconds left',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF5170FD),
        child: Container(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              _timer.cancel();
              _navigateToNext();
            },
            child: currentIndex < widget.questions.length - 1 ? Text('Next') : Text('Finish'),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(QuizQuestion quizQuestion) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                quizQuestion.question,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              children: _buildOptions(quizQuestion.options, quizQuestion.correctOption),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOptions(List<String> options, int correctOption) {
    return options.asMap().entries.map((entry) {
      int index = entry.key;
      String option = entry.value;

      bool isCorrect = index == correctOption;
      bool isSelected = selectedOptions.isNotEmpty ? selectedOptions[currentIndex] == index : false;

      return ListTile(
        title: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.blue : null,
          ),
        ),
        onTap: () {
          setState(() {
            selectedOptions[currentIndex] = index;
          });
        },
      );
    }).toList();
  }

  void _navigateToNext() {
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
        questionTimerSeconds = 10; // Reset timer for the next question
      });
      startTimer();
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _timer.cancel();
      _showResults();
    }
  }

  void _showResults() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedOptions[i] == widget.questions[i].correctOption) {
        correctAnswers++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Text('Correct Answers: $correctAnswers out of ${widget.questions.length}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the results dialog
                Navigator.of(context).pop(); // Close the QuizScreen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }



  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (questionTimerSeconds > 0) {
          questionTimerSeconds--;
        } else {
          _timer.cancel(); // Cancel the timer when it reaches 0
          _navigateToNext(); // Move to the next question when the timer reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer when disposing of the screen
    super.dispose();
  }
}
