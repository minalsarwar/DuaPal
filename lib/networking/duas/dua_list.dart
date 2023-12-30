import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/networking/duas/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/provider.dart'; // Import your providers here

class DuaListScreen extends ConsumerWidget {
  final String title;

  const DuaListScreen({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Update the title
    ref.read(duaListTitleProvider.notifier).state = title;

    // Watch duaListProvider after updating the title
    final duaList = ref.watch(duaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: CustomColors.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: duaList.when(
        loading: () => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.mainColor),
          ),
        ),
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
                        id: dua.id, // Pass the document ID as the title
                        title: dua.title,
                        arabic: dua.arabic,
                        transliteration: dua.transliteration,
                        translation: dua.translation,
                        source: dua.source,
                        count: dua.count,
                        explanation: dua.explanation,
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

// Your CardItem widget and other parts remain unchanged

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
                color: CustomColors.mainColor, // Change the color as needed
              ),
              child: Center(
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
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
