import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendScoreViaEmail(String email, String name, int correctAnswers, int totalQuestions) async {
  String username = 'harshil5858@gmail.com'; // Your email
  String password = 'Harshil@2004'; // Your email password

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username)
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
