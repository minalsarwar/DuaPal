import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/networking/app_state.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String id;
  final String arabic;
  final String transliteration;
  final String translation;
  final String source;
  final int count;

  const DetailScreen(
      {required this.title,
      required this.id,
      required this.arabic,
      required this.transliteration,
      required this.translation,
      required this.source,
      required this.count});

  DetailScreen.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'],
        id = snapshot.id, // Use the document ID directly
        arabic = snapshot['arabic'],
        transliteration = snapshot['transliteration'],
        translation = snapshot['translation'],
        source = snapshot['source'],
        count = snapshot['count'];

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String arabic;
  late String transliteration;
  late String translation;
  late String source;
  late int count;
  int _currentIndex = 0;
  late int originalCount;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    arabic = widget.arabic;
    transliteration = widget.transliteration;
    translation = widget.translation;
    source = widget.source;
    count = widget.count;
    originalCount = count;

    AuthService().getUserId().then((userId) async {
      if (userId != null) {
        String duaId = widget.id;
        // Check if the dua is already a favorite
        bool isAlreadyFavorite = await isDuaFavorite(userId, duaId);

        setState(() {
          isFavorite = isAlreadyFavorite;
        });
      }
    });
  }

  Future<void> toggleFavoriteStatus() async {
    String? userId = await AuthService().getUserId();
    if (userId != null) {
      String duaId = widget.id;

      // Check if the dua is already a favorite
      bool isAlreadyFavorite = await isDuaFavorite(userId, duaId);

      // Toggle the favorite status
      if (isAlreadyFavorite) {
        removeFromFavorites(userId, duaId);
      } else {
        addToFavorites(userId, duaId);
      }

      // Update the UI
      setState(() {
        isFavorite = !isAlreadyFavorite;
      });
    }
  }

  Future<bool> isDuaFavorite(String userId, String duaId) async {
    // Check if the dua is in the user's favorites collection
    QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('user_id', isEqualTo: userId)
        .where('dua_id', isEqualTo: duaId)
        .get();

    return favoritesSnapshot.docs.isNotEmpty;
  }

  Future<void> addToFavorites(String userId, String duaId) async {
    // Add the dua to the user's favorites collection
    await FirebaseFirestore.instance.collection('favorites').add({
      'user_id': userId,
      'dua_id': duaId,
    });
  }

  Future<void> removeFromFavorites(String userId, String duaId) async {
    // Remove the dua from the user's favorites collection
    QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('user_id', isEqualTo: userId)
        .where('dua_id', isEqualTo: duaId)
        .get();

    if (favoritesSnapshot.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(favoritesSnapshot.docs.first.id)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: CustomColors.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                arabic,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 20),
              Text(
                transliteration,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              Text(
                translation,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.bubble_chart_rounded, color: Colors.grey),
                  SizedBox(width: 2),
                  Text(
                    'Source',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                source,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CustomColors.mainColor,
        currentIndex: 0, // Change this value based on your initial selected tab
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Handle the counter functionality here
                // For example, you can increment the count variable
                setState(() {
                  if (count > 0) {
                    count -= 1;
                  }
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.mainColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: count > 0
                      ? Text(
                          count.toString(),
                          style: TextStyle(color: Colors.white),
                        )
                      : IconButton(
                          icon: Icon(Icons.restart_alt, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              count = originalCount;
                            });
                          },
                        ),
                ),
              ),
            ),
            label: 'Count',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                toggleFavoriteStatus();
              },
              child: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : null,
              ),
            ),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}

// bottomNavigationBar: CircleNavBar(
      //   activeIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   activeIcons: [
      //     Icon(Icons.play_arrow),
      //     Icon(Icons.info),
      //     Container(
      //       width: 40,
      //       height: 40,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: CustomColors.mainColor,
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.5),
      //             spreadRadius: 2,
      //             blurRadius: 5,
      //             offset: Offset(0, 3),
      //           ),
      //         ],
      //       ),
      //       child: Center(
      //         child: Text(
      //           count.toString(),
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //     ),
      //     Icon(Icons.share),
      //     Icon(Icons.favorite),
      //   ],
      //   inactiveIcons: [
      //     Icon(Icons.play_arrow),
      //     Icon(Icons.info),
      //     Icon(Icons.circle),
      //     Icon(Icons.share),
      //     Icon(Icons.favorite),
      //   ],
      //   height: 80,
      //   circleWidth: 60,
      //   color: Colors.blue,
      //   circleColor: Colors.white,
      //   padding: EdgeInsets.symmetric(horizontal: 20),
      //   cornerRadius: BorderRadius.circular(30),
      //   shadowColor: Colors.grey,
      //   elevation: 5,
      // ),
 
 