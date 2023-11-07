// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     String appBarTitle = 'Home';

//     switch (_currentIndex) {
//       case 0:
//         appBarTitle = 'Home';
//         break;
//       case 1:
//         appBarTitle = 'Favourites';
//         break;
//       case 2:
//         appBarTitle = 'Journal';
//         break;
//       case 3:
//         appBarTitle = 'Emotions';
//         break;
//       case 4:
//         appBarTitle = 'Reminder';
//         break;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 113, 176, 205),
//         // leading: IconButton(
//         //   icon: Icon(Icons.menu, color: Colors.white),
//         //   onPressed: () {
//         //     // Handle menu/drawer action
//         //   },
//         // ),
//         title: Text(
//           appBarTitle,
//           style: TextStyle(fontSize: 20),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // Handle search action
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.settings, color: Colors.white),
//             onPressed: () {
//               // Handle settings action
//             },
//           ),
//         ],
//       ),
// drawer: Drawer(
//   backgroundColor: Colors.white,
//   child: Column(
//     children: <Widget>[
//       DrawerHeader(
//         decoration: BoxDecoration(color: Colors.white),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset('android/assets/appLogo.png',
//                   height: 70, width: 60),
//             ),
//             Text('Dua Pal',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//       ListTile(
//         leading: Icon(Icons.repeat),
//         title: Text('Tasbih Counter'),
//         onTap: () {
//           // Handle Tasbih Counter action
//         },
//       ),
//       ListTile(
//         leading: Icon(Icons.cloud),
//         title: Text('Feedback'),
//         onTap: () {
//           // Handle Feedback action
//         },
//       ),
//       ListTile(
//         leading: Icon(Icons.help),
//         title: Text('FAQs'),
//         onTap: () {
//           // Handle FAQs action
//         },
//       ),
//       ListTile(
//         leading: Icon(Icons.info),
//         title: Text('About Dua Pal'),
//         onTap: () {
//           // Handle About Dua & Dhikr action
//         },
//       ),
//     ],
//   ),
// ),
//       body: _currentIndex == 3 ? EmotionsContent() : HomeContent(),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Color.fromARGB(255, 113, 176, 205),
//         unselectedItemColor: Colors.grey,
//         selectedFontSize: 14,
//         unselectedFontSize: 14,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favourites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: 'Journal',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.face),
//             label: 'Emotions',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Reminder',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         buildCard('Morning', 'android/assets/morning.jpg'),
//         buildCard('Evening', 'android/assets/evening.jpg'),
//         buildCard('Before Sleep', 'android/assets/beforeSleep.jpg'),
//         buildDoubleCard('Salah', 'android/assets/salah.jpg', 'After Salah',
//             'android/assets/afterSalah.jpg'),
//         buildCard('Ruqyah', 'android/assets/ruqyah.jpg'),
//         buildDoubleCard('Praises of Allah', 'android/assets/praisesofAllah.jpg',
//             'Salawat', 'android/assets/salawat.jpg'),
//         buildDoubleCard('Quranic Duas', 'android/assets/quranicDuas.jpg',
//             'Sunnah Duas', 'android/assets/sunnahDuas.jpg'),
//         buildDoubleCard('Istagfar', 'android/assets/istagfar.jpg',
//             'Dhikr of All Times', 'android/assets/dhikr.jpg'),
//         buildCard('Names of Allah', 'android/assets/namesAllah.jpg'),
//       ],
//     );
//   }

//   Widget buildCard(String title, String imageAsset) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(40.0),
//       child: Card(
//         margin: EdgeInsets.all(10),
//         child: Stack(
//           children: [
//             ColorFiltered(
//               colorFilter: ColorFilter.mode(
//                 Colors.white.withOpacity(0.8),
//                 BlendMode.dstATop,
//               ),
//               child: Container(
//                 height: 110,
//                 width: double.infinity,
//                 child: Image.asset(
//                   imageAsset,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               left: 10,
//               child: Container(
//                 padding: EdgeInsets.all(8), // Adjust padding as needed
//                 color: Colors.black
//                     .withOpacity(0.5), // Adjust opacity and color as needed
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors
//                         .white, // Text color set to white for better visibility
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDoubleCard(
//       String title1, String imageAsset1, String title2, String imageAsset2) {
//     return Row(
//       children: [
//         Expanded(
//           child: buildCard(title1, imageAsset1),
//         ),
//         Expanded(
//           child: buildCard(title2, imageAsset2),
//         ),
//       ],
//     );
//   }
// }

// class EmotionsContent extends StatelessWidget {
//   final List<String> emotionsList = [
//     'Angry',
//     'Anxious',
//     'Bored',
//     'Confident',
//     'Confused',
//     'Content',
//     'Depressed',
//     'Doubtful',
//     'Grateful',
//     'Greedy',
//     'Guilty',
//     'Happy',
//     'Hurt',
//     'Indecisive',
//     'Hypocritical',
//     'Jealous',
//     'Lazy',
//     'Lonely',
//     'Lost',
//     'Nervous',
//     'Overwhelmed',
//     'Regret',
//     'Sad',
//     'Scared',
//     'Suicidal',
//     'Tired',
//     'Unloved',
//     'Weak',
//   ];

//   final List<Color> backgroundColors = [
//     Color.fromRGBO(236, 219, 228, 0.8),
//     Color.fromRGBO(247, 231, 253, 0.8),
//     Color.fromRGBO(224, 241, 203, 0.8),
//     Color.fromRGBO(246, 239, 168, 1),
//     Color.fromRGBO(212, 243, 235, 0.8),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: RichText(
//               text: TextSpan(
//                 style: DefaultTextStyle.of(context).style,
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: 'I am ',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.black,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'feeling...',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1.75,
//                   crossAxisSpacing: 6,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: emotionsList.length,
//                 itemBuilder: (context, index) {
//                   final emotion = emotionsList[index];
//                   final color =
//                       backgroundColors[index % backgroundColors.length];
//                   return EmotionTile(title: emotion, backgroundColor: color);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmotionTile extends StatelessWidget {
//   final String title;
//   final Color backgroundColor;

//   EmotionTile({required this.title, required this.backgroundColor});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: backgroundColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isMainSelected = true;

  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Home';

    switch (_currentIndex) {
      case 0:
        appBarTitle = 'Home';
        break;
      case 1:
        appBarTitle = 'Favourites';
        break;
      case 2:
        appBarTitle = 'Journal';
        break;
      case 3:
        appBarTitle = 'Emotions';
        break;
      case 4:
        appBarTitle = 'Reminder';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 176, 205),
        title: Text(
          appBarTitle,
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('android/assets/appLogo.png',
                        height: 70, width: 60),
                  ),
                  Text('Dua Pal',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text('Tasbih Counter'),
              onTap: () {
                // Handle Tasbih Counter action
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud),
              title: Text('Feedback'),
              onTap: () {
                // Handle Feedback action
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('FAQs'),
              onTap: () {
                // Handle FAQs action
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Dua Pal'),
              onTap: () {
                // Handle About Dua & Dhikr action
              },
            ),
          ],
        ),
      ),
      body: _currentIndex == 3 ? EmotionsContent() : HomeContent(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 113, 176, 205),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Emotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reminder',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _currentIndex = 0;
  bool isMainSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          padding: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMainSelected = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isMainSelected
                        ? Color.fromARGB(255, 113, 176, 205)
                        : Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: Ink(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Main',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isMainSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isMainSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isMainSelected = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: !isMainSelected
                        ? Color.fromARGB(255, 113, 176, 205)
                        : Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: Ink(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Other',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: !isMainSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: !isMainSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isMainSelected ? buildMainContent() : buildOtherContent(),
        ),
      ],
    );
  }

  Widget buildMainContent() {
    return ListView(
      children: [
        buildCard('Morning', 'android/assets/morning.jpg'),
        buildCard('Evening', 'android/assets/evening.jpg'),
        buildCard('Before Sleep', 'android/assets/beforeSleep.jpg'),
        buildDoubleCard('Salah', 'android/assets/salah.jpg', 'After Salah',
            'android/assets/afterSalah.jpg'),
        buildCard('Ruqyah Healing', 'android/assets/ruqyah.jpg'),
        buildDoubleCard('Praises of Allah', 'android/assets/praisesofAllah.jpg',
            'Salawat', 'android/assets/salawat.jpg'),
        buildDoubleCard('Quranic Duas', 'android/assets/quranicDuas.jpg',
            'Sunnah Duas', 'android/assets/sunnahDuas.jpg'),
        buildDoubleCard('Istagfar', 'android/assets/istagfar.jpg',
            'Dhikr of All Times', 'android/assets/dhikr.jpg'),
        buildCard('Names of Allah', 'android/assets/namesAllah.jpg'),
      ],
    );
  }

  Widget buildOtherContent() {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        buildGridCard('Waking Up', 'android/assets/wakingup.jpg'),
        buildGridCard('Nightmares', 'android/assets/nightmares.jpg'),
        buildGridCard('Clothes', 'android/assets/clothes.jpg'),
        buildGridCard('Lavatory & Wudu', 'android/assets/wudu.jpg'),
        buildGridCard('Food & Drink', 'android/assets/food.jpg'),
        buildGridCard('Home', 'android/assets/home.jpg'),
        buildGridCard('Adhan & Masjid', 'android/assets/masjid.jpg'),
        buildGridCard('Istikharah', 'android/assets/istikhara.jpg'),
        buildGridCard('Gatherings', 'android/assets/gatherings.jpg'),
        buildGridCard('Trials & Blessings', 'android/assets/emotions.jpg'),
        buildGridCard('Protection of Iman', 'android/assets/iman.jpg'),
        buildGridCard('Hajj & Umrah', 'android/assets/hajj.jpg'),
        buildGridCard('Travel', 'android/assets/travel.jpg'),
        buildGridCard('Money & Shopping', 'android/assets/shopping.jpg'),
        buildGridCard('Social Interactions', 'android/assets/social.jpg'),
        buildGridCard('Marriage', 'android/assets/marriage.jpg'),
        buildGridCard('Death', 'android/assets/death.jpg'),
        buildGridCard('Nature', 'android/assets/nature.jpg'),
      ],
    );
  }

  Widget buildCard(String title, String imageAsset) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8),
                BlendMode.dstATop,
              ),
              child: Container(
                height: 110,
                width: double.infinity,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoubleCard(
      String title1, String imageAsset1, String title2, String imageAsset2) {
    return Row(
      children: [
        Expanded(
          child: buildCard(title1, imageAsset1),
        ),
        Expanded(
          child: buildCard(title2, imageAsset2),
        ),
      ],
    );
  }
}

Widget buildGridCard(String title, String imageAsset) {
  return Card(
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
      child: Stack(
        children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class EmotionsContent extends StatelessWidget {
  final List<String> emotionsList = [
    'Angry',
    'Anxious',
    'Bored',
    'Confident',
    'Confused',
    'Content',
    'Depressed',
    'Doubtful',
    'Grateful',
    'Greedy',
    'Guilty',
    'Happy',
    'Hurt',
    'Indecisive',
    'Hypocritical',
    'Jealous',
    'Lazy',
    'Lonely',
    'Lost',
    'Nervous',
    'Overwhelmed',
    'Regret',
    'Sad',
    'Scared',
    'Suicidal',
    'Tired',
    'Unloved',
    'Weak',
  ];

  final List<Color> backgroundColors = [
    Color.fromRGBO(236, 219, 228, 0.8),
    Color.fromRGBO(247, 231, 253, 0.8),
    Color.fromRGBO(224, 241, 203, 0.8),
    Color.fromRGBO(246, 239, 168, 1),
    Color.fromRGBO(212, 243, 235, 0.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'I am ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'feeling...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.75,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 10,
                ),
                itemCount: emotionsList.length,
                itemBuilder: (context, index) {
                  final emotion = emotionsList[index];
                  final color =
                      backgroundColors[index % backgroundColors.length];
                  return EmotionTile(title: emotion, backgroundColor: color);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmotionTile extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  EmotionTile({required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
