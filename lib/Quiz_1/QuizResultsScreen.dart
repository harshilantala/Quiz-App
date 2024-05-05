import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class QuizResultsScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final String email;
  final String name;

  QuizResultsScreen({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.email,
    required this.name,
  });

  // Function to send quiz score via email
  void sendScoreViaEmail() async {
    String username = 'harshil5858@gmail.com'; // Your email
    String password = 'rtwi qbpw ltla vzev'; // Your email password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Harshil')
      ..recipients.add(email) // User's email
      ..subject = 'Quiz Score'
      ..text = 'Hello $name,\n\n'
          'Your quiz score is: $correctAnswers out of $totalQuestions.\n\n'
          'Thank you for taking the quiz.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error occurred: $e');
    }
  }

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
        backgroundColor: Color(0xFF003c43),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color(0xFF135D66),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Correct Answers: $correctAnswers out of $totalQuestions',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'User Email: $email',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'User Name: $name',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the function to send the email
                  sendScoreViaEmail();
                },
                child: Text('Send Score via Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
