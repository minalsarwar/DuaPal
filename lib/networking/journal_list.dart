import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/networking/journal_entry.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jorunalList = ref.watch(journalsProvider);

    return Scaffold(
      body: jorunalList.when(
        data: (journals) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: journals.length,
                  itemBuilder: (context, index) {
                    final journal = journals[index];
                    final moodIcon = getMoodIcon(journal.mood);
                    final moodColor = getMoodColor(journal.mood);
                    final truncatedBody = journal.body.length > 20
                        ? '${journal.body.substring(0, 20)}...'
                        : journal.body;

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: journal.color,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              truncatedBody,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(10),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Colors.white, // Set the background color here
                              child: Icon(moodIcon, color: moodColor, size: 40),
                            ),
                            Text(
                              '${journal.mood}',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          '${formatDateTime(journal.dateTime)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            _showDeleteConfirmationDialog(
                              context,
                              journal.id,
                              ref.read(deleteJournalEntryProvider),
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                        onTap: () {
                          ref.read(entryIdProvider.notifier).state = journal.id;
                          ref.read(journalEntryProvider.notifier).state =
                              journal.body;
                          ref.read(selectedEmotionProvider.notifier).state =
                              getMoodIcon(journal.mood);
                          ref.read(selectedDateProvider.notifier).state =
                              journal.dateTime; // DateTime
                          ref.read(selectedTimeProvider.notifier).state =
                              TimeOfDay.fromDateTime(journal
                                  .dateTime); // Convert DateTime to TimeOfDay
                          ref.read(selectedColorProvider.notifier).state =
                              journal.color;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => JournalEntryScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Error: $error'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.mainColor,
        shape: CircleBorder(),
        onPressed: () {
          ref.refresh(journalEntryProvider);
          ref.refresh(selectedEmotionProvider);
          ref.refresh(selectedDateProvider);
          ref.refresh(selectedTimeProvider);
          ref.refresh(selectedColorProvider);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => JournalEntryScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData getMoodIcon(String mood) {
    switch (mood) {
      case 'Great':
        return Icons.sentiment_very_satisfied;
      case 'Good':
        return Icons.sentiment_satisfied;
      case 'Normal':
        return Icons.sentiment_neutral;
      case 'Sad':
        return Icons.sentiment_dissatisfied;
      case 'Emotional':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'Great':
        return Color.fromARGB(255, 242, 234, 90);
      case 'Good':
        return Color.fromARGB(255, 147, 248, 114);
      case 'Normal':
        return Color.fromARGB(255, 250, 189, 98);
      case 'Sad':
        return Color.fromARGB(255, 116, 188, 251);
      case 'Emotional':
        return Color.fromARGB(255, 245, 114, 105);
      default:
        return Colors.blue; // Default color
    }
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    String documentId,
    void Function(String) deleteFunction,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Journal Entry'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',
                  style: TextStyle(color: CustomColors.mainColor)),
            ),
            TextButton(
              onPressed: () {
                deleteFunction(documentId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
