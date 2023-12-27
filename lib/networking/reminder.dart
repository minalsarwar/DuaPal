// import 'package:flutter/material.dart';

// class ReminderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0), // Add the desired top padding
//       child: Container(
//         height: 500,
//         margin: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.0),
//                 topRight: Radius.circular(20.0),
//               ),
//               child: Image.asset(
//                 'android/assets/gaza.jpg',
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Padding(
//               padding: EdgeInsets.all(3.0),
//               child: Center(
//                 child: Text(
//                   'The Promise of Allah',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red[900],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Do not think that Allah is unaware of what the wrongdoers do. He only delays them until a Day when ˹their˺ eyes will stare in horror— [14:42]',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20.0),
//                   Icon(
//                     Icons.share,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ReminderScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final AsyncValue<List<Reminder>> reminders = ref.watch(remindersProvider);

//     return reminders.when(
//       data: (data) {
//         if (data.isEmpty) {
//           return Container(); // Placeholder or loading indicator
//         }

//         final random = Random();
//         final randomIndex = random.nextInt(data.length);
//         final selectedReminder = data[randomIndex];

//         return Container(
//           height: 600,
//           margin: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                 ),
//                 child: Image.network(
//                   selectedReminder.image,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Padding(
//                 padding: EdgeInsets.all(3.0),
//                 child: Center(
//                   child: Text(
//                     selectedReminder.title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red[900],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       selectedReminder.description,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.0),
//                     Icon(
//                       Icons.share,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       loading: () => CircularProgressIndicator(),
//       error: (error, stackTrace) => Text('Error fetching reminders'),
//     );
//   }
// }

// reminder.dart
// reminder.dart
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error fetching reminders'),
    );
  }

  // void _share(BuildContext context, String title, String description) {
  //   print(title);

  //   // You can customize the sharePositionOrigin based on your app's UI
  //   Rect? sharePositionOrigin = Rect.fromPoints(
  //     Offset(0, MediaQuery.of(context).size.height), // Bottom-left corner
  //     Offset(MediaQuery.of(context).size.width,
  //         MediaQuery.of(context).size.height), // Bottom-right corner
  //   );

  //   Share.share(
  //     '$title\n\n$description',
  //     subject: 'Optional subject',
  //     sharePositionOrigin: sharePositionOrigin,
  //   );
  // }

  void _share(BuildContext context, String title, String description,
      String imageUrl) async {
    print(title);

    // Download the image from the network
    final response = await http.get(Uri.parse(imageUrl));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      final List<int> buffer = response.bodyBytes;

      // Save the image to a temporary file
      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/image.jpg');
      await tempFile.writeAsBytes(buffer);

      // Create a list of files to share
      final List<String> files = [tempFile.path];

      // You can customize the sharePositionOrigin based on your app's UI
      Rect? sharePositionOrigin = Rect.fromPoints(
        Offset(0, MediaQuery.of(context).size.height), // Bottom-left corner
        Offset(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height), // Bottom-right corner
      );

      // Share both text and image
      Share.shareFiles(
        files,
        text: '$title\n\n$description',
        subject: 'Optional subject',
        sharePositionOrigin: sharePositionOrigin,
      );
    } else {
      // Handle the case where the image couldn't be loaded
      print('Failed to load image. Status code: ${response.statusCode}');
    }
  }
}
