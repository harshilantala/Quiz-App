import 'package:flutter/material.dart';

class SubjectSelectionPage extends StatelessWidget {
  final List<String> subjects = ['HTML', 'CSS', 'Java', 'Python', 'C', 'C++' , 'Dart' , 'DBMS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Select a Subject'),
        backgroundColor: Color(0xFF478DE0),

      ),
      backgroundColor: Color(0xFF61A4F1),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return SubjectCard(subject: subjects[index]);
        },
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subject;

  SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle subject selection here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage(subject: subject)),
          );
        },
        borderRadius: BorderRadius.circular(15.0),
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/logos/$subject.png'),
              // backgroundColor: Colors.black,
            ),
            SizedBox(height: 10.0),
            Text(
              subject,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String subject;

  NextPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text(
          'You selected: $subject',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
