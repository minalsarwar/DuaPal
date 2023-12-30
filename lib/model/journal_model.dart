import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JournalModel {
  final String id;
  final String mood;
  final String body;
  final DateTime dateTime;
  final Color color; // Add color to the model
  final String userID;

  JournalModel({
    required this.id,
    required this.body,
    required this.dateTime,
    required this.mood,
    required this.color,
    required this.userID,
  });

  factory JournalModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return JournalModel(
      id: document.id,
      body: document['body'] ?? '',
      mood: document['mood'] ?? '',
      dateTime: (document['dateTime'] as Timestamp).toDate(),
      color:
          Color(document['color'] ?? Color.fromARGB(197, 199, 222, 241).value),
      userID: document['userID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'mood': mood,
      'dateTime': Timestamp.fromDate(dateTime),
      'color': color.value, // Store color as an integer
      'userID': userID,
    };
  }
}
