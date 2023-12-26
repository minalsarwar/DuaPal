import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/dua_model.dart';
import 'package:flutter_application_1/networking/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<User?>((ref) {
  return null;
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// final duaListProvider = StreamProvider<List<DuaModel>>(
//   (ref) {
//     // Use .snapshots() to listen for changes in the Firestore collection
//     return FirebaseFirestore.instance.collection('dua_detail').snapshots().map(
//       (snapshot) {
//         return snapshot.docs.map((doc) => DuaModel.fromFirestore(doc)).toList();
//       },
//     );
//   },
// );

//homepage

final duaListTitleProvider = StateProvider<String>((ref) {
  // The initial category title is set to an empty string
  return '';
});

final duaListProvider = StreamProvider<List<DuaModel>>((ref) {
  final title = ref.watch(duaListTitleProvider);
  final isEmotionTileSelected = ref.watch(isEmotionTileSelectedProvider);

  Query query;
  if (isEmotionTileSelected) {
    query = FirebaseFirestore.instance
        .collection('dua_detail')
        .where('emotion', isEqualTo: title);
  } else {
    query = FirebaseFirestore.instance
        .collection('dua_detail')
        .where('category', isEqualTo: title);
  }

  return query.snapshots().map(
    (snapshot) {
      return snapshot.docs
          .map((doc) => DuaModel.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
    },
  );
});

final isEmotionTileSelectedProvider = StateProvider<bool>((ref) {
  return false;
});

final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final confirmPasswordControllerProvider =
    Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final isEmailTooLongProvider = Provider<bool>((ref) {
  return ref.watch(emailControllerProvider).text.length > 50;
});

final isMainSelectedProvider = StateProvider<bool>((ref) {
  return true;
});

// final passwordsMatchProvider = StateProvider<bool>((ref) => true);

// final isPasswordVisibleProvider = StateProvider<bool>((ref) {
//   return false;
// });
