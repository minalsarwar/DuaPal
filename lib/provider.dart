import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/dua_model.dart';
import 'package:flutter_application_1/model/journal_model.dart';
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

//journal entry providers

// // Provider for the journal entry text
// final journalEntryProvider = StateProvider<String>((ref) => '');

// // Provider for managing the selected emotion
// final selectedEmotionProvider = StateProvider<IconData?>((ref) => null);

// // Provider for managing the selected date
// final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// // Provider for managing the selected time
// final selectedTimeProvider = StateProvider<TimeOfDay?>((ref) => null);

// // Provider for managing the selected color
// final selectedColorProvider =
//     StateProvider<Color>((ref) => Color.fromARGB(197, 199, 222, 241));

// // Provider for getting the user ID
// final userIDProvider = Provider<String>((ref) => 'YOUR_USER_ID'); // Replace with actual user ID

// // Provider for saving the journal entry to Firestore
// final saveJournalEntryProvider = Provider<void Function()>(
//   (ref) => () async {
//     final journalEntry = ref.read(journalEntryProvider.notifier).state;
//     final selectedEmotion = ref.read(selectedEmotionProvider.notifier).state;
//     final selectedDate = ref.read(selectedDateProvider.notifier).state;
//     final selectedTime = ref.read(selectedTimeProvider.notifier).state;
//     final selectedColor = ref.read(selectedColorProvider.notifier).state;
//     final userID = ref.read(userIDProvider);

//     if (journalEntry.isNotEmpty &&
//         selectedEmotion != null &&
//         selectedDate != null &&
//         selectedTime != null) {
//       final entry = JournalModel(
//         id: '',
//         body: journalEntry,
//         date: selectedDate.toIso8601String(),
//         mood: getEmotionText(selectedEmotion),
//         time: selectedTime.format(ref.read(context)),
//         userID: userID,
//       );

//       // Save the entry to Firestore
//       await FirebaseFirestore.instance.collection('journals').add(
//             entry.toMap(),
//           );

//       // Clear the journal entry text after saving
//       ref.read(journalEntryProvider.notifier).state = '';
//     }
//   },
// );

String getEmotionText(IconData emotion) {
  // You might implement logic to convert IconData to text
  // Replace this with your actual logic
  return 'EmotionText';
}
