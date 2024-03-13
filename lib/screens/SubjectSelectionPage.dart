import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Quiz_1/quiz_question.dart';
import '../Quiz_1/quiz_screen.dart';
import '../Quiz_1/quiz_service.dart';

class UserNotifier extends ChangeNotifier {
  String userName = '';

  void updateUserName(String name) {
    userName = name;
    notifyListeners();
  }
}

class SubjectSelectionPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> subjects = [
    {'name': 'HTML', 'image': 'html.png'},
    {'name': 'CSS', 'image': 'css.png'},
    {'name': 'Java', 'image': 'java.png'},
    {'name': 'Python', 'image': 'python.png'},
    {'name': 'C', 'image': 'c.png'},
    {'name': 'C++', 'image': 'c++.png'}
  ];

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF5170FD),
        elevation: 0,
        title: Text(
          'Q U I Z A P P',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.person , color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[300]!, Colors.deepPurple[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Welcome, ${userNotifier.userName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Color(0xFF5170FD),
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.lightBlue, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select a Subject',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return SubjectCard(
                    subject: subjects[index]['name']!,
                    imagePath: 'assets/logos/${subjects[index]['image']!}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final QuizService quizService = QuizService();
  final String subject;
  final String imagePath;

  SubjectCard({required this.subject, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          _navigateToQuizScreen(context, subject);
        },
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              subject,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToQuizScreen(BuildContext context, String subject) async {
    try {
      List<QuizQuestion> quizQuestions = await quizService.loadQuestions(subject);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: quizQuestions),
        ),
      );
    } catch (e) {
      print('Error loading quiz questions: $e');
    }
  }
}
