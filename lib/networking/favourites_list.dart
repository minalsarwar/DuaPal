import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/model/dua_model.dart';
import 'package:flutter_application_1/networking/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/provider.dart'; // Import your providers here

class FavListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favList = ref.watch(favProvider);

    return Scaffold(
      body: favList.when(
        loading: () => Center(
          child: CircularProgressIndicator(
            // valueColor: AlwaysStoppedAnimation<Color>(CustomColors.mainColor),
          ),
        ),
        error: (error, stack) => Text('Error: $error'),
        data: (favs) {
          if (favs.isEmpty) {
            // Display a message when there are no favorites yet
            return Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final fav = favs[index];
              return GestureDetector(
                onTap: () async {
                  // Navigate to the detail screen when a card is tapped
                  DuaModel duaModel = await fetchDuaModel(fav.dua_id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: fav.dua_id, // Pass the document ID as the title
                        title: duaModel.title,
                        arabic: duaModel.arabic,
                        transliteration: duaModel.transliteration,
                        translation: duaModel.translation,
                        source: duaModel.source,
                        count: duaModel.count,
                        explanation: duaModel.explanation,
                      ),
                    ),
                  );
                },
                child: CardItem(
                  itemCount: index + 1, // Item count starts from 1
                  duaId: fav.dua_id,
                  docId: fav.id,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int itemCount;
  final String duaId;
  final String docId;

  const CardItem({
    required this.itemCount,
    required this.duaId,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder<DuaModel>(
          future: fetchDuaModel(duaId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final duaModel = snapshot.data!;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Filled circle with item count
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.mainColor,
                        ),
                        child: Center(
                          child: Text(
                            itemCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Title
                      Expanded(
                        child: Text(
                          duaModel.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Delete icon
                      GestureDetector(
                        onTap: () {
                          ref.read(deleteFavProvider)(docId);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red, // Filled heart color
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

Future<DuaModel> fetchDuaModel(String duaId) async {
  // Reference to the specific document in the dua_detail collection
  DocumentReference<Map<String, dynamic>> docRef =
      FirebaseFirestore.instance.collection('dua_detail').doc(duaId);

  // Fetch the document snapshot
  DocumentSnapshot<Map<String, dynamic>> duaSnapshot = await docRef.get();

  // Create a DuaModel from the document snapshot
  DuaModel duaModel = DuaModel.fromFirestore(duaSnapshot);

  return duaModel;
}
