import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DatabaseService{
  Future<void> addQuizData(Map quizData, String quizId) async{
    await Firestore.instance.collection("Quiz")
    .document(quizId).setData(quizData).catchError((e){
     print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId)async{
    await Firestore.instance.collection("Quiz")
        .document(quizId).collection("QNA")
        .add(questionData)//add will generate random id by itself and adding our map to the collection as document
        .catchError((e){
          print(e.toString());
    });
  }

  getQuizesData()async{
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  getQuizData(String quizId)async{
    return await Firestore.instance.
    collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  getTeachersData()async{
    return await Firestore.instance.collection("Teacher").snapshots();
  }

  getExamData()async{
    return await Firestore.instance.collection("Exam").snapshots();
  }
}


