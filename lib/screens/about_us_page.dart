import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF003c43),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color(0xFF135D66), // Use the app's background color
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This Application is created and managed by:',
              style: TextStyle(fontSize: 20, color: Color(0xFFE3FEF7)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '22CS005 (Harshil Antala)\n22CS007 (Nand Banugariya)',
              style: TextStyle(fontSize: 18, color: Color(0xFFE3FEF7)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
