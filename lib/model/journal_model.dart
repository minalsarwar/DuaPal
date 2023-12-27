import 'package:cloud_firestore/cloud_firestore.dart';

class JournalModel {
  final String id;
  final String mood;
  final String body;
  final String date;

  final String time;
  final String userID;

  JournalModel({
    required this.id,
    required this.body,
    required this.date,
    required this.mood,
    required this.time,
    required this.userID,
  });

  factory JournalModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return JournalModel(
        id: document.id,
        body: document['body'] ?? '',
        mood: document['mood'] ?? '',
        date: document['date'] ?? '',
        time: document['time'] ?? '',
        userID: document['userID'] ?? '');
  }
}
