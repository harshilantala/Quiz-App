import 'package:flutter/material.dart';

class QuizResultsScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  QuizResultsScreen({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF003c43), // App bar color
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
      ),
      body: Container(
        color: Color(0xFF135D66), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Font color
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Correct Answers: $correctAnswers out of $totalQuestions',
                style: TextStyle(color: Colors.white), // Font color
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
