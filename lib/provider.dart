import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/model/dua_model.dart';
import 'package:flutter_application_1/model/fav_model.dart';
import 'package:flutter_application_1/model/journal_model.dart';
import 'package:flutter_application_1/networking/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final authProvider = StateProvider<User?>((ref) {
  return null;
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final currentIndexProvider = StateProvider<int>((ref) => 0);

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

final isEmailValidProvider = StateProvider<bool>((ref) {
  return true;
});

final isPasswordVisibleProvider = StateProvider<bool>((ref) {
  return false;
});

final doPasswordsMatchProvider = StateProvider<bool>((ref) {
  return true;
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
    StateProvider<Color>((ref) => CustomColors.lightColor);

final entryIdProvider = StateProvider<String?>((ref) => null);

final saveJournalEntryProvider = Provider<void Function(String?)>(
  (ref) => (String? entryId) async {
    final journalEntry = ref.read(journalEntryProvider.notifier).state;
    final selectedEmotion = ref.read(selectedEmotionProvider.notifier).state;
    final selectedDate = ref.read(selectedDateProvider.notifier).state;
    final selectedTime = ref.read(selectedTimeProvider.notifier).state;
    final selectedColor = ref.read(selectedColorProvider.notifier).state;
    String? userID = ref.watch(userIDProvider);

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
        } else {
          // If entryId is provided, update the existing entry
          await FirebaseFirestore.instance
              .collection('journals')
              .doc(entryId)
              .update(entry.toMap());
        }
        ref.refresh(journalEntryProvider);
        ref.refresh(selectedEmotionProvider);
        ref.refresh(selectedDateProvider);
        ref.refresh(selectedTimeProvider);
        ref.refresh(selectedColorProvider);
        ref.refresh(entryIdProvider);
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
  String? userID = ref.watch(userIDProvider);
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
final userIDProvider = StateProvider<String?>((ref) {
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

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]);

  // void removeFromFavorites(String duaId) {
  //   print('Removing dua from favorites with ID: $duaId');

  //   FirebaseFirestore.instance
  //       .collection('favorites')
  //       .where('user_id', isEqualTo: AuthService().getUserId())
  //       .where('dua_id', isEqualTo: duaId)
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     if (snapshot.docs.isNotEmpty) {
  //       snapshot.docs.first.reference.delete();

  //       state = state.where((id) => id != duaId).toList();
  //     }
  //   });
  // }

//   void removeFromFavorites(String userId, String duaId) {
//   print('Removing dua from favorites with ID: $duaId');

//   FirebaseFirestore.instance
//       .collection('favorites')
//       .where('user_id', isEqualTo: userId)
//       .where('dua_id', isEqualTo: duaId)
//       .get()
//       .then((QuerySnapshot snapshot) {
//     if (snapshot.docs.isNotEmpty) {
//       snapshot.docs.first.reference.delete();

//       state = state.where((id) => id != duaId).toList();
//     }
//   });
// }

  Future<void> removeFromFavorites(String duaId) async {
    print('Removing dua from favorites with ID: $duaId');

    // Access userId directly from AuthService
    String? userId = await AuthService().getUserId();
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('favorites')
          .where('user_id', isEqualTo: userId)
          .where('dua_id', isEqualTo: duaId)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.isNotEmpty) {
          await snapshot.docs.first.reference.delete();

          state = state.where((id) => id != duaId).toList();
        }
      });
    }

    // Add a return statement to satisfy the return type
    return Future.value();
  }

  void addToFavorites(String duaId) {
    FirebaseFirestore.instance.collection('favorites').add({
      'user_id': AuthService().getUserId(),
      'dua_id': duaId,
    }).then((_) {
      // Add to state
      state = [...state, duaId];
    });
  }
}

final detailTitleProvider = StateProvider<String?>((ref) => null);

//reminder

final remindersProvider = StreamProvider<List<Reminder>>((ref) {
  return FirebaseFirestore.instance.collection('reminders').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Reminder.fromSnapshot(doc)).toList());
});

class Reminder {
  final String title;
  final String description;
  final String image;

  Reminder(
      {required this.title, required this.description, required this.image});

  factory Reminder.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Reminder(
      title: data['title'],
      description: data['description'],
      image: data['image'],
    );
  }
}

//////
final favProvider = StreamProvider<List<FavModel>>((ref) {
  String? userID = ref.watch(userIDProvider);
  print('USER ID: ${userID ?? "User not signed in"}');

  Query query = FirebaseFirestore.instance
      .collection('favorites')
      .where('user_id', isEqualTo: userID);

  return query.snapshots().map(
    (snapshot) {
      List<FavModel> favList = snapshot.docs
          .map((doc) => FavModel.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();

      return favList;
    },
  );
});

final deleteFavProvider = Provider<void Function(String)>((ref) {
  return (String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(documentId)
          .delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle the error as needed
    }
  };
});

//audio

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

final audioPositionProvider = StreamProvider<Duration?>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.positionStream;
});

final audioStateProvider =
    StateNotifierProvider<AudioStateNotifier, AudioState>((ref) {
  return AudioStateNotifier(ref);
});

class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  AudioState({
    required this.isPlaying,
    required this.position,
    required this.duration,
  });
}

class AudioStateNotifier extends StateNotifier<AudioState> {
  final Ref _ref;

  AudioStateNotifier(this._ref)
      : super(AudioState(
            isPlaying: false,
            position: Duration.zero,
            duration: Duration.zero));

  AudioPlayer get _audioPlayer => _ref.read(audioPlayerProvider);

  Future<void> playPause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    _updateState();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
    _updateState();
  }

  void _updateState() {
    state = AudioState(
      isPlaying: _audioPlayer.playing,
      position: _audioPlayer.position,
      duration: _audioPlayer.duration ?? Duration.zero,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

//settings
final arabicTextSizeProvider = StateProvider<double>((ref) => 16.0);
final transliterationTextSizeProvider = StateProvider<double>((ref) => 16.0);
final translationTextSizeProvider = StateProvider<double>((ref) => 16.0);
final sourceTextSizeProvider = StateProvider<double>((ref) => 16.0);
final showTranslationsProvider = StateProvider<bool>((ref) => true);
final showTransliterationProvider = StateProvider<bool>((ref) => true);
final selectedArabicFontProvider = StateProvider<String>((ref) => "Naskh");
