import 'package:cloud_firestore/cloud_firestore.dart';

class DuaModel {
  final String id;
  final String title;
  final String arabic;
  final String transliteration;
  final String translation;
  final String source;
  final int count;
  final String explanation;

  DuaModel(
      {required this.id,
      required this.title,
      required this.arabic,
      required this.transliteration,
      required this.translation,
      required this.source,
      required this.count,
      required this.explanation});

  // Create a factory method to convert Firestore document to DuaModel
  factory DuaModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return DuaModel(
        id: document.id,
        title: document['title'] ?? '',
        arabic: document['arabic'] ?? '',
        transliteration: document['transliteration'] ?? '',
        translation: document['translation'] ?? '',
        source: document['source'] ?? '',
        count: document['count'] ?? 0,
        explanation: document['explanation'] ?? '');
  }
}
