// import 'package:flutter/material.dart';

// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             margin: EdgeInsets.all(16.0),
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 Icon(Icons.search),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.folder_open),
//                   title: Text(index == 0 ? 'Thank you Allah' : 'Tawakkul'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FavoritesDetailScreen(
//                           title: index == 0 ? 'Thank you Allah' : 'Tawakkul',
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FavoritesDetailScreen extends StatelessWidget {
//   final String title;

//   FavoritesDetailScreen({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.all(16.0),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 5, // Number of card tiles
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.folder_open),
//                   title: Text('Dua ${index + 1}'),
//                   // Add onTap functionality here
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String? detailTitle;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (detailTitle != null) {
          // If a detail screen is shown, navigate back to the main screen
          setState(() {
            detailTitle = null;
          });
          return false; // Prevent the default back button behavior
        }
        return true; // Allow the default back button behavior (e.g., exit the app)
      },
      child: Container(
        child: detailTitle == null
            ? buildMainContent()
            : buildDetailContent(detailTitle!),
      ),
    );
  }

  Widget buildMainContent() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.folder_open),
                title: Text(index == 0 ? 'Thank you Allah' : 'Tawakkul'),
                onTap: () {
                  setState(() {
                    detailTitle = index == 0 ? 'Thank you Allah' : 'Tawakkul';
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDetailContent(String title) {
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
            itemCount: 5, // Number of card tiles
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.favorite_sharp, color: Colors.red),
                title: Text('Dua ${index + 1}'),
                // Add onTap functionality here
              );
            },
          ),
        ),
      ],
    );
  }
}
