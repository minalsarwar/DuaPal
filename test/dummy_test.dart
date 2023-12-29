// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/firebase_options.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/networking/home_page.dart';
// import 'package:flutter_application_1/networking/login.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

// void main() {
//   setUpAll(() => loadAppFonts());
//   testGoldens('description', (tester) async {
//     // WidgetsFlutterBinding.ensureInitialized();
//     // await Firebase.initializeApp();
//     final builder = DeviceBuilder()
//       ..overrideDevicesForAllScenarios(devices: [
//         Device.phone,
//         Device.iphone11,
//         Device.tabletPortrait,
//         Device.tabletLandscape,
//       ])
//       ..addScenario(
//         widget: ProviderScope(
//           child: HomeScreen(),
//         ),
//         name: 'sc page',
//       );

//     await tester.pumpDeviceBuilder(builder,
//         wrapper: materialAppWrapper(
//           theme: ThemeData.light(),
//           platform: TargetPlatform.android,
//         ));

//     await screenMatchesGolden(tester, 'first_screen_shot');
//   });
// }

// // // class FirebaseInitWrapper extends StatefulWidget {
// // //   final Widget child;

// // //   FirebaseInitWrapper({required this.child});

// // //   @override
// // //   _FirebaseInitWrapperState createState() => _FirebaseInitWrapperState();
// // // }

// // // class _FirebaseInitWrapperState extends State<FirebaseInitWrapper> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     initializeFirebase();
// // //   }

// // //   Future<void> initializeFirebase() async {
// // //     WidgetsFlutterBinding.ensureInitialized();
// // //     await Firebase.initializeApp(
// // //       options: DefaultFirebaseOptions.currentPlatform,
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return widget.child;
// // //   }
// // // }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/firebase_options.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/networking/app_state.dart';
// import 'package:flutter_application_1/networking/login.dart';
// import 'package:flutter_application_1/networking/mock_firebase.dart';
// import 'package:flutter_application_1/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

// void main() {
//   setUpAll(() async {
//     await loadAppFonts();
//     // await Firebase.initializeApp();
//   });

//   testGoldens('description', (tester) async {
//     // Use the mock authentication service
//     final mockAuthService = MockAuthService();

//     // Replace the real authentication service with the mock service
//     // You might need to adjust this based on your actual implementation
//     // E.g., provide the mockAuthService in a ProviderContainer
//     final container = ProviderContainer(
//       overrides: [
//         authServiceProvider.overrideWithValue(mockAuthService as AuthService),
//       ],
//     );

//     final builder = DeviceBuilder()
//       ..overrideDevicesForAllScenarios(devices: [
//         Device.phone,
//         Device.iphone11,
//         Device.tabletPortrait,
//         Device.tabletLandscape,
//       ])
//       ..addScenario(
//         widget: ProviderScope(
//           parent: container,
//           child: LoginPage(),
//         ),
//         name: 'sc page',
//       );

//     await tester.pumpDeviceBuilder(
//       builder,
//       wrapper: materialAppWrapper(
//         theme: ThemeData.light(),
//         platform: TargetPlatform.android,
//       ),
//     );

//     await screenMatchesGolden(tester, 'first_screen_shot');
//   });
// }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/networking/login.dart';
// import 'package:flutter_application_1/networking/mock_firebase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_application_1/networking/app_state.dart';
// import 'package:flutter_application_1/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

// void main() {
//   setUpAll(() async {
//     await loadAppFonts();
//     await Firebase.initializeApp();
//   });

//   testGoldens('description', (tester) async {
//     // Use the mock authentication service
//     final mockAuthService = MockAuthService();

//     // Replace the real authentication service with the mock service
//     final container = ProviderContainer(
//       overrides: [
//         authServiceProvider.overrideWithValue(mockAuthService as AuthService),
//       ],
//     );

//     final builder = DeviceBuilder()
//       ..overrideDevicesForAllScenarios(devices: [
//         Device.phone,
//         Device.iphone11,
//         Device.tabletPortrait,
//         Device.tabletLandscape,
//       ])
//       ..addScenario(
//         widget: ProviderScope(
//           parent: container,
//           child: LoginPage(), // Replace with your actual widget
//         ),
//         name: 'sc page',
//       );

//        await tester.pumpDeviceBuilder(
//       builder,
//       wrapper: materialAppWrapper(
//         theme: ThemeData.light(),
//         platform: TargetPlatform.android,
//       ),
//     );

//     await screenMatchesGolden(tester, 'first_screen_shot');
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/networking/login.dart';
// import 'package:flutter_application_1/networking/mock_firebase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_application_1/networking/app_state.dart';
// import 'package:flutter_application_1/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';
// import 'package:mockito/mockito.dart';

// // Import the mock version of firebase_core
// import 'package:firebase_core_mocks/firebase_core_mocks.dart';

// void main() {
//   // Use a mock version of Firebase for testing
//   final mockFirebase = MockFirebase();

//   setUpAll(() async {
//     await loadAppFonts();
//     // Initialize the mock Firebase instead of the real one
//     await mockFirebase.initializeApp();
//   });

//   testGoldens('description', (tester) async {
//     // Use the mock authentication service
//     final mockAuthService = MockAuthService();

//     // Replace the real authentication service with the mock service
//     final container = ProviderContainer(
//       overrides: [
//         authServiceProvider.overrideWithValue(mockAuthService as AuthService),
//       ],
//     );

//     final builder = DeviceBuilder()
//       ..overrideDevicesForAllScenarios(devices: [
//         Device.phone,
//         Device.iphone11,
//         Device.tabletPortrait,
//         Device.tabletLandscape,
//       ])
//       ..addScenario(
//         widget: ProviderScope(
//           parent: container,
//           child: LoginPage(), // Replace with your actual widget
//         ),
//         name: 'sc page',
//       );

//     await tester.pumpDeviceBuilder(
//       builder,
//       wrapper: materialAppWrapper(
//         theme: ThemeData.light(),
//         platform: TargetPlatform.android,
//       ),
//     );

//     await screenMatchesGolden(tester, 'first_screen_shot');
//   });
// }
