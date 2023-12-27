// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/networking/app_state.dart';
// import 'package:flutter_application_1/networking/dua_detail.dart';
// import 'package:flutter_application_1/provider.dart';

// class FavoritesScreen extends StatefulWidget {
//   @override
//   _FavoritesScreenState createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   String? detailTitle;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (detailTitle != null) {
//           // If a detail screen is shown, navigate back to the main screen
//           setState(() {
//             detailTitle = null;
//           });
//           return false; // Prevent the default back button behavior
//         }
//         return true; // Allow the default back button behavior (e.g., exit the app)
//       },
//       child: Container(
//         child: detailTitle == null
//             ? buildMainContent()
//             : buildDetailContent(detailTitle!),
//       ),
//     );
//   }

//   Widget buildMainContent() {
//     return FutureBuilder(
//       future: fetchUserFavorites(),
//       builder: (context, AsyncSnapshot<List<DetailScreen>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: snapshot.data?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     return FavoriteDuaTile(
//                       duaDetailModel: snapshot.data![index],
//                       onRemove: () {
//                         // Implement the logic to remove dua from favorites
//                         removeFromFavorites(snapshot.data![index].id);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }

//   Future<List<DetailScreen>> fetchUserFavorites() async {
//     String? userId = await AuthService().getUserId();
//     if (userId != null) {
//       QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
//           .collection('favorites')
//           .where('user_id', isEqualTo: userId)
//           .get();

//       List<String> favoriteDuaIds = favoritesSnapshot.docs
//           .map((doc) => doc['dua_id'].toString())
//           .toList();

//       // Fetch dua details using dua IDs
//       List<DetailScreen> favoriteDuas = [];
//       for (String duaId in favoriteDuaIds) {
//         DocumentSnapshot duaDetailSnapshot = await FirebaseFirestore.instance
//             .collection('dua_detail')
//             .doc(duaId)
//             .get();

//         DetailScreen duaDetailModel =
//             DetailScreen.fromSnapshot(duaDetailSnapshot);
//         favoriteDuas.add(duaDetailModel);
//       }

//       return favoriteDuas;
//     } else {
//       return [];
//     }
//   }

//   void removeFromFavorites(String duaId) {
//     // Implement the logic to remove the dua from favorites collection
//     Future<String?> userId = AuthService().getUserId();
//     print('Removing dua from favorites with ID: $duaId');
//     if (userId != null) {
//       FirebaseFirestore.instance
//           .collection('favorites')
//           .where('user_id', isEqualTo: userId)
//           .where('dua_id', isEqualTo: duaId)
//           .get()
//           .then((QuerySnapshot snapshot) {
//         if (snapshot.docs.isNotEmpty) {
//           snapshot.docs.first.reference.delete();
//         }
//       });
//     }
//   }

//   Widget buildDetailContent(String title) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.all(16.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: 5,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 leading: Icon(Icons.favorite_sharp, color: Colors.red),
//                 title: Text('Dua ${index + 1}'),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class FavoriteDuaTile extends StatelessWidget {
//   final DetailScreen duaDetailModel;
//   final VoidCallback onRemove;

//   FavoriteDuaTile({required this.duaDetailModel, required this.onRemove});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(duaDetailModel.title),
//       trailing: IconButton(
//         icon: Icon(Icons.favorite, color: Colors.red),
//         onPressed: onRemove,
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DetailScreen(
//               title: duaDetailModel.title,
//               id: duaDetailModel.id,
//               arabic: duaDetailModel.arabic,
//               transliteration: duaDetailModel.transliteration,
//               translation: duaDetailModel.translation,
//               source: duaDetailModel.source,
//               count: duaDetailModel.count,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/networking/app_state.dart';
import 'package:flutter_application_1/networking/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/provider.dart';

class FavoritesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? detailTitle;

    return WillPopScope(
      onWillPop: () async {
        if (detailTitle != null) {
          // If a detail screen is shown, navigate back to the main screen
          ref.read(detailTitleProvider.notifier).state = null;
          return false; // Prevent the default back button behavior
        }
        return true; // Allow the default back button behavior (e.g., exit the app)
      },
      child: Container(
        child: detailTitle == null
            ? buildMainContent(ref)
            : buildDetailContent(detailTitle!, ref),
      ),
    );
  }

  Future<List<DetailScreen>> fetchUserFavorites(WidgetRef ref) async {
    String? userId = await AuthService().getUserId();
    if (userId != null) {
      QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('user_id', isEqualTo: userId)
          .get();

      List<String> favoriteDuaIds = favoritesSnapshot.docs
          .map((doc) => doc['dua_id'].toString())
          .toList();

      // Fetch dua details using dua IDs
      List<DetailScreen> favoriteDuas = [];
      for (String duaId in favoriteDuaIds) {
        DocumentSnapshot duaDetailSnapshot = await FirebaseFirestore.instance
            .collection('dua_detail')
            .doc(duaId)
            .get();

        DetailScreen duaDetailModel =
            DetailScreen.fromSnapshot(duaDetailSnapshot);
        favoriteDuas.add(duaDetailModel);
      }

      return favoriteDuas;
    } else {
      return [];
    }
  }

  Widget buildMainContent(WidgetRef ref) {
    return FutureBuilder(
      future: fetchUserFavorites(ref),
      builder: (context, AsyncSnapshot<List<DetailScreen>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return FavoriteDuaTile(
                      duaDetailModel: snapshot.data![index],
                      onRemove: () async {
                        await ref
                            .read(favoritesProvider.notifier)
                            .removeFromFavorites(snapshot.data![index].id);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildDetailContent(String title, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.favorite_sharp, color: Colors.red),
                title: Text('Dua ${index + 1}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FavoriteDuaTile extends StatelessWidget {
  final DetailScreen duaDetailModel;
  final Future<void> Function() onRemove;

  FavoriteDuaTile({required this.duaDetailModel, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(duaDetailModel.title),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () async {
            await onRemove();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Dua removed from favorites'),
              ),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                title: duaDetailModel.title,
                id: duaDetailModel.id,
                arabic: duaDetailModel.arabic,
                transliteration: duaDetailModel.transliteration,
                translation: duaDetailModel.translation,
                source: duaDetailModel.source,
                count: duaDetailModel.count,
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<void> onRemoveAsync(
  //     String duaId, BuildContext context, WidgetRef ref) async {
  //   ref.read(favoritesProvider.notifier).removeFromFavorites(userId,duaId);
  // }
}
