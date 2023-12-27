// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/main.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

// void main() {
//   setUpAll(() => loadAppFonts());
//   testGoldens('description', (tester) async {
//     final builder = DeviceBuilder()
//       ..overrideDevicesForAllScenarios(devices: [
//         Device.phone,
//         Device.iphone11,
//         Device.tabletPortrait,
//         Device.tabletLandscape,
//       ])
//       ..addScenario(
//         widget: MyApp(),
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

