import 'package:flutter/material.dart';

class JournalEntryScreen extends StatefulWidget {
  const JournalEntryScreen({Key? key}) : super(key: key);

  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  IconData? selectedEmotion;
  TextEditingController journalEntryController = TextEditingController();
  Color selectedColor = Color.fromARGB(197, 199, 222, 241); // Default color

  // Function to update the selected emotion
  void updateSelectedEmotion(IconData icon) {
    setState(() {
      selectedEmotion = icon;
    });
  }

  // Function to update the selected color
  void updateSelectedColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onPressed: () =>
                        updateSelectedEmotion(Icons.sentiment_very_satisfied),
                    isSelected:
                        selectedEmotion == Icons.sentiment_very_satisfied,
                  ),
                  EmotionOption(
                    icon: Icons.sentiment_satisfied,
                    colour: Color.fromARGB(255, 147, 248, 114),
                    text: 'Good',
                    onPressed: () =>
                        updateSelectedEmotion(Icons.sentiment_satisfied),
                    isSelected: selectedEmotion == Icons.sentiment_satisfied,
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
                    isSelected: selectedEmotion == Icons.sentiment_dissatisfied,
                  ),
                  EmotionOption(
                    icon: Icons.sentiment_very_dissatisfied,
                    colour: Color.fromARGB(255, 245, 114, 105),
                    text: 'Emotional',
                    onPressed: () => updateSelectedEmotion(
                        Icons.sentiment_very_dissatisfied),
                    isSelected:
                        selectedEmotion == Icons.sentiment_very_dissatisfied,
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
                        TextButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text(
                            (selectedDate != null
                                ? '${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}'
                                : 'Select a date'),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 90),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time), // Add time icon
                        TextButton(
                          onPressed: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedTime = pickedTime;
                              });
                            }
                          },
                          child: Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : 'Select a time',
                            style: const TextStyle(fontSize: 15),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ColorOption(
                        color: Color.fromARGB(255, 248, 210, 208),
                        isSelected:
                            selectedColor == Color.fromARGB(255, 248, 210, 208),
                        onPressed: () => updateSelectedColor(
                            Color.fromARGB(255, 248, 210, 208)),
                      ),
                      ColorOption(
                        color: Color.fromARGB(194, 211, 231, 212),
                        isSelected:
                            selectedColor == Color.fromARGB(194, 211, 231, 212),
                        onPressed: () => updateSelectedColor(
                            Color.fromARGB(194, 211, 231, 212)),
                      ),
                      ColorOption(
                        color: Color.fromARGB(197, 245, 210, 245),
                        isSelected:
                            selectedColor == Color.fromARGB(197, 245, 210, 245),
                        onPressed: () => updateSelectedColor(
                          Color.fromARGB(197, 245, 210, 245),
                        ),
                      ),
                      ColorOption(
                        color: Color.fromARGB(186, 245, 241, 197),
                        isSelected:
                            selectedColor == Color.fromARGB(186, 245, 241, 197),
                        onPressed: () => updateSelectedColor(
                            Color.fromARGB(186, 245, 241, 197)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        iconSize: 23,
                        onPressed: () {
                          updateSelectedColor(
                              Color.fromARGB(197, 199, 222, 241));
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit the journal entry
                      // You can access the journal entry text using journalEntryController.text
                    },
                  ),
                ],
              ),

              // Color options for the text box

              // Text box with selected color
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity, // Set the width to fill the screen
                    height: 350, // Set the height to your desired value
                    decoration: BoxDecoration(
                      color:
                          selectedColor, // Background color based on selection
                      border: Border.all(
                          color: Color.fromARGB(255, 217, 224, 227),
                          width: 2), // Add a border for a page-like appearance
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: journalEntryController,
                        decoration: InputDecoration(
                          hintText: 'Dear Allah, today has been...',
                          border: InputBorder.none, // Remove the default border
                        ),
                        maxLines: null, // Allows multiple lines of text
                        enableSuggestions: true, // Allow content to be pasted
                        style: TextStyle(
                          fontSize: 16, // Increase text size for readability
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              Center(
                child: Container(
                  width: 75,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save the journal entry as a draft
                      // You can access the journal entry text using journalEntryController.text
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 113, 176, 205), // Set the background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Make it rounder
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionOption extends StatefulWidget {
  final IconData icon;
  final Color colour; // Change this to Color
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
        Icon(
          widget.icon,
          size: 36,
          color: widget.colour, // Use the color based on selection
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.text,
          style: TextStyle(
            color: Colors.black, // Use the color based on selection
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
          width: 20, // Set the width to your desired size
          height: 20, // Set the height to your desired size
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            border: Border.all(
              color: widget.isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
        ));
  }
}
