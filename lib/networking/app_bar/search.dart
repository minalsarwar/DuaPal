import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/networking/duas/dua_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/provider.dart'; // Import your providers here

class SearchScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider); // Watch the provider
    final searchResult = ref.watch(searchResultProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                if (text.isEmpty) {
                  ref.read(searchTextProvider.notifier).state = "null";
                } else {
                  // Update the searchTextProvider when text changes
                  ref.read(searchTextProvider.notifier).state = text;
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter your search text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: CustomColors.mainColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: CustomColors.mainColor,
                  ),
                ),
              ),
            ),
          ),

          // Search Results
          Expanded(
            child: searchResult.when(
              loading: () => Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColors.mainColor),
                ),
              ),
              error: (error, stack) => Text('Error: $error'),
              data: (duas) {
                if (searchText == "null") {
                  return Center(
                    child: Text(
                      'Start searching!',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  );
                } else if (duas.isEmpty && searchText != "null") {
                  // Display a message when there are no results
                  return Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  );
                }
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
                              explanation: dua.explanation,
                            ),
                          ),
                        );
                      },
                      child: CardItem(
                        itemCount: index + 1,
                        title: dua.title,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
