import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/networking/home_page.dart';
import 'package:flutter_application_1/networking/login.dart';
import 'package:flutter_application_1/networking/signup.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/networking/app_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(
  // ProviderScope(
  //   child: const MyApp(),
  // ),
  runApp(const MyApp());
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue, // Light theme
        ),
        //Adding dark theme
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Color.fromARGB(255, 90, 85, 85),
        ),

        //System's theme setting or use the light/dark theme explicitly.
        themeMode: ThemeMode.system, // Or use ThemeMode.light or ThemeMode.dark
        // home: const MyHomePage(title: 'Flutter Demo Home Page: Minal'),
        // home: const HomeScreen(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/homepage': (context) => HomeScreen(),
        },
        initialRoute: '/login',
        home: LoginPage(),

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'), // Arabic
          Locale('en'), // English
        ],
        locale: const Locale('en'),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize Firebase within MyApp
//     WidgetsFlutterBinding.ensureInitialized();
//     Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );

//     return ProviderScope(
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue, // Light theme
//         ),
//         // Adding dark theme
//         darkTheme: ThemeData.dark().copyWith(
//           primaryColor: Color.fromARGB(255, 90, 85, 85),
//         ),

//         // System's theme setting or use the light/dark theme explicitly.
//         themeMode: ThemeMode.system, // Or use ThemeMode.light or ThemeMode.dark
//         // home: const MyHomePage(title: 'Flutter Demo Home Page: Minal'),
//         // home: const HomeScreen(),
//         routes: {
//           '/login': (context) => LoginPage(),
//           '/signup': (context) => SignUpPage(),
//           '/homepage': (context) => HomeScreen(),
//         },
//         initialRoute: '/login',
//         home: LoginPage(),

//         localizationsDelegates: const [
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//         ],
//         supportedLocales: const [
//           Locale('ar'), // Arabic
//           Locale('en'), // English
//         ],
//         locale: const Locale('en'),
//       ),
//     );
//   }
// }
