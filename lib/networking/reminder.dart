import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class ReminderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Reminder>> reminders = ref.watch(remindersProvider);

    return reminders.when(
      data: (data) {
        if (data.isEmpty) {
          return Container(); // Placeholder or loading indicator
        }

        final random = Random();
        final randomIndex = random.nextInt(data.length);
        final selectedReminder = data[randomIndex];

        return Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Image.network(
                  selectedReminder.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Center(
                  child: Text(
                    selectedReminder.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      selectedReminder.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Implement share functionality here
                        _share(
                            context,
                            selectedReminder.title,
                            selectedReminder.description,
                            selectedReminder.image);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => CircularProgressIndicator(
        color: CustomColors.mainColor,
      ),
      error: (error, stackTrace) => Text('Error fetching reminders'),
    );
  }

  void _share(
      BuildContext context, String title, String description, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
              SizedBox(height: 8),
              Text(title),
              Text(description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Use the share package to share data
                Share.share('$title\n\n$description\n$imageUrl');
                Navigator.of(context).pop();
              },
              child: Text('Share'),
            ),
          ],
        );
      },
    );
  }
}
