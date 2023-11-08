import 'package:flutter/material.dart';

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
