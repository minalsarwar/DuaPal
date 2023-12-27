import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavModel {
  final String id;
  final String user_id;
  final String dua_id;

  FavModel({required this.id, required this.user_id, required this.dua_id});

  factory FavModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return FavModel(
        id: document.id,
        user_id: document['user_id'] ?? '',
        dua_id: document['dua_id'] ?? '');
  }
}
