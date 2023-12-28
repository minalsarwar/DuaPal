import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.mainColor,
        title: Text(
          'FAQs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FaqTile(
              question: 'What is Dua Pal?',
              answer:
                  'Dua Pal is an app created to assist Muslims in their spiritual journey by providing dua cards, reminders, journaling, and favorites features.',
            ),
            FaqTile(
              question: 'How do I add a dua to my favorites?',
              answer:
                  'To add a dua to your favorites, simply navigate to the dua details and tap the heart icon.',
            ),
            FaqTile(
              question: 'Can I customize the dua reminders?',
              answer:
                  'Yes, you can customize the dua reminders by going to the settings and selecting the desired notification time.',
            ),
            FaqTile(
              question: 'Is my journaling data secure?',
              answer:
                  'Yes, your journaling data is securely stored on your device. It is not shared or synced with any external servers.',
            ),
            FaqTile(
              question: 'How can I provide feedback about the app?',
              answer:
                  'We appreciate your feedback! You can submit your feedback through the "Feedback" section in the app settings.',
            ),
          ],
        ),
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  FaqTile({required this.question, required this.answer});

  @override
  _FaqTileState createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 41, 164, 171),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.answer,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
