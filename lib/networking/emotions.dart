import 'package:flutter/material.dart';
import 'package:flutter_application_1/networking/duas/dua_list.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmotionsContent extends ConsumerWidget {
  final List<String> emotionsList = [
    'Angry',
    'Happy',
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
  Widget build(BuildContext context, WidgetRef ref) {
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
                  return EmotionTile(
                    title: emotion,
                    backgroundColor: color,
                    onTap: () {
                      // Handle the tap event
                      ref.read(isEmotionTileSelectedProvider.notifier).state =
                          true;
                      ref.read(duaListTitleProvider.notifier).state = emotion;
                      Navigator.push(
                        ref.context,
                        MaterialPageRoute(
                          builder: (context) => DuaListScreen(title: emotion),
                        ),
                      );
                    },
                  );
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
  final Function() onTap;

  EmotionTile({
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger the onTap callback when the tile is tapped
      child: Card(
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
      ),
    );
  }
}
