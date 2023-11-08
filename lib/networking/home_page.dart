import 'package:flutter/material.dart';
import 'package:flutter_application_1/networking/emotions.dart';
import 'package:flutter_application_1/networking/journal_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.white),
        //   onPressed: () {
        //     // Handle menu/drawer action
        //   },
        // ),
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
      // body: _currentIndex == 3 ? EmotionsContent() : HomeContent(),
      body: _currentIndex == 3
          ? EmotionsContent()
          : _currentIndex == 2
              ? JournalEntryScreen()
              : HomeContent(),
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

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildCard('Morning', 'android/assets/morning.jpg'),
        buildCard('Evening', 'android/assets/evening.jpg'),
        buildCard('Before Sleep', 'android/assets/beforeSleep.jpg'),
        buildDoubleCard('Salah', 'android/assets/salah.jpg', 'After Salah',
            'android/assets/afterSalah.jpg'),
        buildCard('Ruqyah', 'android/assets/ruqyah.jpg'),
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

  Widget buildCard(String title, String imageAsset) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Card(
        margin: EdgeInsets.all(10),
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
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
