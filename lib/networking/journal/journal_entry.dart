import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/networking/home_page.dart';
import 'package:flutter_application_1/networking/journal/journal_list.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class JournalEntryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryID = ref.watch(entryIdProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedEmotion = ref.watch(selectedEmotionProvider);
    final journalEntryController = TextEditingController.fromValue(
      TextEditingValue(text: ref.read(journalEntryProvider.notifier).state),
    );
    final selectedColor = ref.watch(selectedColorProvider);

    void updateSelectedEmotion(IconData icon) {
      ref.read(selectedEmotionProvider.notifier).state = icon;
    }

    void updateSelectedColor(Color color) {
      ref.read(selectedColorProvider.notifier).state = color;
    }

    return Scaffold(
        appBar: AppBar(
            title: Text('Journal Entry',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: CustomColors.mainColor,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Emotion icons and options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EmotionOption(
                        icon: Icons.sentiment_very_satisfied,
                        colour: Color.fromARGB(255, 242, 234, 90),
                        text: 'Great',
                        onPressed: () => updateSelectedEmotion(
                            Icons.sentiment_very_satisfied),
                        isSelected:
                            selectedEmotion == Icons.sentiment_very_satisfied,
                      ),
                      EmotionOption(
                        icon: Icons.sentiment_satisfied,
                        colour: Color.fromARGB(255, 147, 248, 114),
                        text: 'Good',
                        onPressed: () =>
                            updateSelectedEmotion(Icons.sentiment_satisfied),
                        isSelected:
                            selectedEmotion == Icons.sentiment_satisfied,
                      ),
                      EmotionOption(
                        icon: Icons.sentiment_neutral,
                        colour: Color.fromARGB(255, 250, 189, 98),
                        text: 'Normal',
                        onPressed: () =>
                            updateSelectedEmotion(Icons.sentiment_neutral),
                        isSelected: selectedEmotion == Icons.sentiment_neutral,
                      ),
                      EmotionOption(
                        icon: Icons.sentiment_dissatisfied,
                        colour: Color.fromARGB(255, 116, 188, 251),
                        text: 'Sad',
                        onPressed: () =>
                            updateSelectedEmotion(Icons.sentiment_dissatisfied),
                        isSelected:
                            selectedEmotion == Icons.sentiment_dissatisfied,
                      ),
                      EmotionOption(
                        icon: Icons.sentiment_very_dissatisfied,
                        colour: Color.fromARGB(255, 245, 114, 105),
                        text: 'Emotional',
                        onPressed: () => updateSelectedEmotion(
                            Icons.sentiment_very_dissatisfied),
                        isSelected: selectedEmotion ==
                            Icons.sentiment_very_dissatisfied,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today), // Add calendar icon
                            SizedBox(
                                width:
                                    8), // Add some space between icon and text
                            Flexible(
                              // Use Flexible to allow text to wrap
                              child: TextButton(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    // Use ref to update the selectedDateProvider
                                    ref
                                        .read(selectedDateProvider.notifier)
                                        .state = pickedDate;
                                  }
                                },
                                child: Text(
                                  (selectedDate != null
                                      ? '${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}'
                                      : 'Select a date'),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width:
                              16), // Add some space between date and time pickers
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.access_time), // Add time icon
                            SizedBox(
                                width:
                                    8), // Add some space between icon and text
                            Flexible(
                              // Use Flexible to allow text to wrap
                              child: TextButton(
                                onPressed: () async {
                                  final pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        selectedTime ?? TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    // Use ref to update the selectedTimeProvider
                                    ref
                                        .read(selectedTimeProvider.notifier)
                                        .state = pickedTime;
                                  }
                                },
                                child: Text(
                                  selectedTime != null
                                      ? selectedTime!.format(context)
                                      : 'Select a time',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: const Text(
                          'Reflections for today',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ColorOption(
                            color: Color.fromARGB(255, 248, 210, 208),
                            isSelected: selectedColor ==
                                Color.fromARGB(255, 248, 210, 208),
                            onPressed: () => updateSelectedColor(
                                Color.fromARGB(255, 248, 210, 208)),
                          ),
                          ColorOption(
                            color: Color.fromARGB(194, 211, 231, 212),
                            isSelected: selectedColor ==
                                Color.fromARGB(194, 211, 231, 212),
                            onPressed: () => updateSelectedColor(
                                Color.fromARGB(194, 211, 231, 212)),
                          ),
                          ColorOption(
                            color: Color.fromARGB(197, 245, 210, 245),
                            isSelected: selectedColor ==
                                Color.fromARGB(197, 245, 210, 245),
                            onPressed: () => updateSelectedColor(
                              Color.fromARGB(197, 245, 210, 245),
                            ),
                          ),
                          ColorOption(
                            color: Color.fromARGB(186, 245, 241, 197),
                            isSelected: selectedColor ==
                                Color.fromARGB(186, 245, 241, 197),
                            onPressed: () => updateSelectedColor(
                                Color.fromARGB(186, 245, 241, 197)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel),
                            iconSize: 23,
                            onPressed: () {
                              updateSelectedColor(CustomColors.lightColor);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Color options for the text box

                  // Text box with selected color
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          color: selectedColor,
                          border: Border.all(
                              color: Color.fromARGB(255, 217, 224, 227),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: journalEntryController,
                            onChanged: (value) => ref
                                .read(journalEntryProvider.notifier)
                                .state = value,
                            decoration: InputDecoration(
                              hintText: 'Dear Allah, today has been...',
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            enableSuggestions: true,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 90,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Check if an emotion is selected
                          if (selectedEmotion == null) {
                            // Show an error message for missing emotion
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select an emotion',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17)),
                                duration: Duration(seconds: 2),
                                backgroundColor: CustomColors.mainColor,
                              ),
                            );
                            return;
                          }

                          // Check if a date is selected
                          if (selectedDate == null) {
                            // Show an error message for missing date
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please select a date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17)),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: CustomColors.mainColor),
                            );
                            return;
                          }

                          // Check if a time is selected
                          if (selectedTime == null) {
                            // Show an error message for missing time
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please select a time',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17)),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: CustomColors.mainColor),
                            );
                            return;
                          }

                          // Check if the text body is null or empty
                          if (journalEntryController.text == null ||
                              journalEntryController.text.isEmpty) {
                            // Show an error message for missing text body
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                    'Please enter your reflections',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: CustomColors.mainColor),
                            );
                            return;
                          }

                          try {
                            // Call the provider function to save the journal entry
                            ref.read(saveJournalEntryProvider)(entryID);
                          } catch (e) {
                            // Handle the error (e.g., show an error message to the user)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error saving journal entry: $e'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          // Update the current index to navigate to the desired screen
                          ref.read(currentIndexProvider.notifier).state = 2;

                          // Navigate to HomeScreen after saving
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class EmotionOption extends StatefulWidget {
  final IconData icon;
  final Color colour;
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  EmotionOption({
    required this.icon,
    required this.colour,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  _EmotionOptionState createState() => _EmotionOptionState();
}

class _EmotionOptionState extends State<EmotionOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          child: IconButton(
            icon: Icon(
              widget.icon,
              size: 36,
              color: widget.colour,
            ),
            onPressed: widget.onPressed,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.text,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ColorOption extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  ColorOption({
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  _ColorOptionState createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          border: Border.all(
            color: widget.isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
