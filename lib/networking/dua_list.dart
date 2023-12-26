// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/networking/dua_detail.dart';

// class DuaListScreen extends StatelessWidget {
//   final String title;

//   const DuaListScreen({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Color.fromARGB(255, 113, 176, 205),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         future: FirebaseFirestore.instance.collection('dua_detail').get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List<DocumentSnapshot<Map<String, dynamic>>> documents =
//                 snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot<Map<String, dynamic>> document =
//                     documents[index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to the detail screen when a card is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           id: document.id, // Pass the document ID as the title
//                           title: document['title'] ?? '',
//                           arabic: document['arabic'] ?? '',
//                           transliteration: document['transliteration'] ?? '',
//                           translation: document['translation'] ?? '',
//                           source: document['source'] ?? '',
//                           count: document['count'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: CardItem(
//                     itemCount: index + 1, // Item count starts from 1
//                     title: document['title'] ?? 'Item ${index + 1}',
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class CardItem extends StatelessWidget {
//   final int itemCount;
//   final String title;

//   const CardItem({required this.itemCount, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Filled circle with item count
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color.fromARGB(
//                     143, 113, 176, 205), // Change the color as needed
//               ),
//               child: Center(
//                 child: Text(
//                   itemCount.toString(),
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 16),
//             // Title
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/networking/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/provider.dart';

class DuaListScreen extends ConsumerWidget {
  final String title;

  const DuaListScreen({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duaList = ref.watch(duaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color.fromARGB(255, 113, 176, 205),
        centerTitle: true,
      ),
      body: duaList.when(
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
        data: (duas) {
          return ListView.builder(
            itemCount: duas.length,
            itemBuilder: (context, index) {
              final dua = duas[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the detail screen when a card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: dua.id,
                        title: dua.title,
                        arabic: dua.arabic,
                        transliteration: dua.transliteration,
                        translation: dua.translation,
                        source: dua.source,
                        count: dua.count,
                      ),
                    ),
                  );
                },
                child: CardItem(
                  itemCount: index + 1, // Item count starts from 1
                  title: dua.title,
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
  final String title;

  const CardItem({required this.itemCount, required this.title});

  @override
  Widget build(BuildContext context) {
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
                color: Color.fromARGB(
                    143, 113, 176, 205), // Change the color as needed
              ),
              child: Center(
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.black,
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
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
