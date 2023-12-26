import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/dua_model.dart';
import 'package:flutter_application_1/networking/app_state.dart';
import 'package:flutter_application_1/networking/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<User?>((ref) {
  return null;
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final duaListProvider = StreamProvider<List<DuaModel>>(
  (ref) {
    // Use .snapshots() to listen for changes in the Firestore collection
    return FirebaseFirestore.instance.collection('dua_detail').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => DuaModel.fromFirestore(doc)).toList();
      },
    );
  },
);

final selectedDuaProvider = Provider<DuaModel?>((ref) => null);

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

// final passwordsMatchProvider = StateProvider<bool>((ref) => true);

// final isPasswordVisibleProvider = StateProvider<bool>((ref) {
//   return false;
// });

//counter logic

class CountNotifier extends Notifier<int> {
  CountNotifier() : super();

  void incrementCount() {
    state++;
  }

  void decrementCount() {
    if (state > 0) {
      state--;
    }
  }

  void resetCount() {
    state = 0;
  }

  @override
  int build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final countNotifierProvider = NotifierProvider<CountNotifier, int>((ref) {
  return CountNotifier();
} as CountNotifier Function());

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavoriteDua>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<FavoriteDua>> {
  FavoritesNotifier() : super([]);

  void addToFavorites(String title, String id) {
    state = [...state, FavoriteDua(title: title, id: id)];
  }

  void removeFromFavorites(String id) {
    state = state.where((dua) => dua.id != id).toList();
  }

  bool isFavorite(String id) {
    return state.any((dua) => dua.id == id);
  }
}

class FavoriteDua {
  final String title;
  final String id;

  FavoriteDua({
    required this.title,
    required this.id,
  });
}
