import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.mainColor,
        title: Text(
          'About Dua Pal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/003/450/412/original/muslim-hijab-girl-illustration-vector.jpg',
                      ),
                    ),
                    SizedBox(width: 16), // Adjusted the width between circles
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/51/bd/ec/51bdec9c6b1b42e993d540ec4c418bc7.jpg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'Dua Pal is created by two friends on a mission to make the journey towards God peaceful and loving. We believe that reciting duas and adhkar in daily life is essential for every Muslim.  It offers dua cards for various occasions, reminders for your daily adhkar, a journaling feature to record your reflections, and the ability to mark your favorite dua for quick access. Dua Pal is your companion to assist you in this journey, bringing peace and tranquility to your life and to enhance your spiritual journey. Remember us in your duas as well! 💖',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 41, 164, 171),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
