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
// Provider for the journal entry text
final journalEntryProvider = StateProvider<String>((ref) => '');

// Provider for managing the selected emotion
final selectedEmotionProvider = StateProvider<IconData?>((ref) => null);

// Provider for managing the selected date
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// Provider for managing the selected time
final selectedTimeProvider = StateProvider<TimeOfDay?>((ref) => null);

// Provider for managing the selected color
final selectedColorProvider =
    StateProvider<Color>((ref) => Color.fromARGB(197, 199, 222, 241));

final entryIdProvider = StateProvider<String?>((ref) => null);

final saveJournalEntryProvider = Provider<void Function(String?)>(
  (ref) => (String? entryId) async {
    final journalEntry = ref.read(journalEntryProvider.notifier).state;
    final selectedEmotion = ref.read(selectedEmotionProvider.notifier).state;
    final selectedDate = ref.read(selectedDateProvider.notifier).state;
    final selectedTime = ref.read(selectedTimeProvider.notifier).state;
    final selectedColor = ref.read(selectedColorProvider.notifier).state;
    String? userID = ref.read(userIDProvider);

    if (journalEntry.isNotEmpty &&
        selectedEmotion != null &&
        selectedDate != null &&
        selectedTime != null &&
        userID != null) {
      // Check if userID is not null
      final entry = JournalModel(
        id: entryId ?? '', // Use provided entryId or an empty string
        body: journalEntry,
        dateTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
        mood: getEmotionText(selectedEmotion),
        color: selectedColor,
        userID: userID,
      );

      try {
        if (entryId == null) {
          // If entryId is null, add a new entry
          await FirebaseFirestore.instance.collection('journals').add(
                entry.toMap(),
              );
          print('SAVEDDD');
          ref.refresh(journalEntryProvider);
          ref.refresh(selectedEmotionProvider);
          ref.refresh(selectedDateProvider);
          ref.refresh(selectedTimeProvider);
          ref.refresh(selectedColorProvider);
        } else {
          // If entryId is provided, update the existing entry
          await FirebaseFirestore.instance
              .collection('journals')
              .doc(entryId)
              .update(entry.toMap());
        }
      } catch (e) {
        print('Error saving to Firestore: $e');
      }
    }
  },
);

String getEmotionText(IconData? selectedEmotion) {
  if (selectedEmotion == Icons.sentiment_very_satisfied) {
    return 'Great';
  } else if (selectedEmotion == Icons.sentiment_satisfied) {
    return 'Good';
  } else if (selectedEmotion == Icons.sentiment_neutral) {
    return 'Normal';
  } else if (selectedEmotion == Icons.sentiment_dissatisfied) {
    return 'Sad';
  } else if (selectedEmotion == Icons.sentiment_very_dissatisfied) {
    return 'Emotional';
  } else {
    return '';
  }
}

final journalsProvider = StreamProvider<List<JournalModel>>((ref) {
  String? userID = ref.read(userIDProvider);
  print('USER ID: ${userID ?? "User not signed in"}');

  Query query = FirebaseFirestore.instance
      .collection('journals')
      .where('userID', isEqualTo: userID);

  return query.snapshots().map(
    (snapshot) {
      List<JournalModel> journalList = snapshot.docs
          .map((doc) => JournalModel.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();

      // Sort the list based on dateTime
      journalList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      return journalList;
    },
  );
});

// Provider for user ID
final userIDProvider = Provider<String?>((ref) {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    String userId = user.uid;
    return userId;
  } else {
    // User is not signed in
    return null;
  }
});

final deleteJournalEntryProvider = Provider<void Function(String)>((ref) {
  return (String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('journals')
          .doc(documentId)
          .delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle the error as needed
    }
  };
});
