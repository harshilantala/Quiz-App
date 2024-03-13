import 'dart:convert';
import 'package:flutter/services.dart';
import 'quiz_question.dart';

class QuizService {
  Future<List<QuizQuestion>> loadQuestions(String subject) async {
    String jsonString = await rootBundle.loadString('assets/quiz_questions.json');
    List<dynamic> jsonList = json.decode(jsonString)['subjects'];

    // Find the subject in the list
    var subjectData = jsonList.firstWhere((element) => element['name'] == subject, orElse: () => null);

    if (subjectData != null) {
      List<dynamic> questionsJson = subjectData['questions'];
      List<QuizQuestion> questions = questionsJson.map((json) => QuizQuestion.fromJson(json)).toList();
      return questions;
    } else {
      throw Exception('Subject not found');
    }
  }
}
