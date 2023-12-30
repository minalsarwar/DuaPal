import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double arabicTextSize = ref.watch(arabicTextSizeProvider);
    double transliterationTextSize = ref.watch(transliterationTextSizeProvider);
    double translationTextSize = ref.watch(translationTextSizeProvider);
    double sourceTextSize = ref.watch(sourceTextSizeProvider);
    bool showTranslations = ref.watch(showTranslationsProvider);
    bool showTransliteration = ref.watch(showTransliterationProvider);
    String selectedArabicFont = ref.watch(selectedArabicFontProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.mainColor,
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: ListView(
          children: [
            buildArabicFontPickerTile(ref),
            buildTextSizeSettingSlider(
              leadingIcon: Icons.text_fields,
              title: 'Arabic Text Size',
              value: arabicTextSize,
              onChanged: (value) {
                ref.read(arabicTextSizeProvider.notifier).state = value;
                // Handle text size change
              },
            ),
            buildTextSizeSettingSlider(
              leadingIcon: Icons.text_fields,
              title: 'Transliteration Text Size',
              value: transliterationTextSize,
              onChanged: (value) {
                ref.read(transliterationTextSizeProvider.notifier).state =
                    value;
                // Handle text size change
              },
            ),
            buildTextSizeSettingSlider(
              leadingIcon: Icons.text_fields,
              title: 'Translation Text Size',
              value: translationTextSize,
              onChanged: (value) {
                ref.read(translationTextSizeProvider.notifier).state = value;
                // Handle text size change
              },
            ),
            buildTextSizeSettingSlider(
              leadingIcon: Icons.text_fields,
              title: 'Source Text Size',
              value: sourceTextSize,
              onChanged: (value) {
                ref.read(sourceTextSizeProvider.notifier).state = value;
                // Handle text size change
              },
            ),
            buildToggleSettingTile(
              leadingIcon: Icons.language,
              title: 'Transliteration',
              value: showTransliteration,
              onChanged: (value) {
                ref.read(showTransliterationProvider.notifier).state = value;
                // Handle toggle change
              },
            ),
            buildToggleSettingTile(
              leadingIcon: Icons.translate,
              title: 'Translation',
              value: showTranslations,
              onChanged: (value) {
                ref.read(showTranslationsProvider.notifier).state = value;
                // Handle toggle change
              },
            ),
            buildTextPreviewTile(
                selectedArabicFont: selectedArabicFont, ref: ref),
          ],
        ));
  }

  Widget buildArabicFontPickerTile(WidgetRef ref) {
    String selectedArabicFont =
        ref.watch(selectedArabicFontProvider.notifier).state;

    return ListTile(
      leading: Icon(Icons.font_download, color: CustomColors.mainColor),
      title: Text('Choose Arabic Font'),
      trailing: DropdownButton<String>(
        value: selectedArabicFont,
        onChanged: (String? selectedFont) {
          if (selectedFont != null) {
            ref.read(selectedArabicFontProvider.notifier).state = selectedFont;
          }
        },
        items: [
          "Naskh",
          "Kufi",
          "Sans",
          // Add other font options as needed
        ].map((String font) {
          return DropdownMenuItem<String>(
            value: font,
            child: Text(font),
          );
        }).toList(),
      ),
    );
  }

  // ... (other methods remain the same)

  Widget buildTextSizeSettingSlider({
    required IconData leadingIcon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return ListTile(
      title: Row(
        children: [
          Icon(leadingIcon, color: CustomColors.mainColor),
          SizedBox(width: 16.0), // Adjust the spacing as needed
          Text(title),
        ],
      ),
      subtitle: Slider(
        activeColor: CustomColors.mainColor,
        value: value,
        onChanged: onChanged,
        min: 10.0,
        max: 30.0,
        divisions: 20,
        label: value.round().toString(),
      ),
    );
  }

  Widget buildToggleSettingTile(
      {required IconData leadingIcon,
      required String title,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return ListTile(
      leading: Icon(leadingIcon, color: CustomColors.mainColor),
      title: Text(title),
      trailing: Switch(
        activeTrackColor: CustomColors.mainColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget buildTextPreviewTile({
    required String selectedArabicFont,
    required WidgetRef ref,
  }) {
    double arabicTextSize = ref.watch(arabicTextSizeProvider);
    double transliterationTextSize = ref.watch(transliterationTextSizeProvider);
    double translationTextSize = ref.watch(translationTextSizeProvider);
    double sourceTextSize = ref.watch(sourceTextSizeProvider);
    bool showTranslations = ref.watch(showTranslationsProvider);
    bool showTransliteration = ref.watch(showTransliterationProvider);

    // Add logic to get the actual text to preview
    String arabic = "لَا إِلَٰهَ إِلَّا ٱللَّٰهُ";
    String transliteration = 'La Ilaha Illallah';
    String translation = 'There is no God but Allah';
    String source =
        "Say, 'He is Allah, [who is] One, Allah, the Eternal Refuge. "
        "He neither begets nor is born, Nor is there to Him any equivalent.' "
        "(Surah Al-Ikhlas, 112:1–4)";

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Text Preview',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Card(
            elevation: 4.0,
            color: CustomColors.lightColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    arabic,
                    style:
                        getArabicFontStyle(selectedArabicFont, arabicTextSize),
                  ),
                  if (showTransliteration)
                    Text(
                      transliteration,
                      style: TextStyle(fontSize: transliterationTextSize),
                    ),
                  if (showTranslations)
                    Text(
                      translation,
                      style: TextStyle(fontSize: translationTextSize),
                    ),
                  Text(
                    source,
                    style: TextStyle(fontSize: sourceTextSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle getArabicFontStyle(String font, double size) {
    switch (font) {
      case "Naskh":
        return GoogleFonts.notoNaskhArabic(
          textStyle: TextStyle(
            fontSize: size,
          ),
        );
      case "Kufi":
        return GoogleFonts.notoKufiArabic(
          textStyle: TextStyle(
            fontSize: size,
          ),
        );
      case "Sans":
        return GoogleFonts.notoSansArabic(
          textStyle: TextStyle(
            fontSize: size,
          ),
        );
      // Add other font options as needed
      default:
        return TextStyle(
          fontSize: size,
        );
    }
  }
}
