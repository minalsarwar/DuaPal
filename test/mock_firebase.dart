// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter_application_1/networking/app_state.dart';
// import 'package:mockito/mockito.dart';

// //
// // class MockAuthService extends Mock implements MockFirebaseAuth {}
// class MockAuthService extends Mock implements AuthService {}

// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User?> authStateChanges() {
//     // Return a stream with a mock user
//     final mockUser = MockUser();
//     return Stream.value(mockUser);
//   }

//   @override
//   Future<MockUser?> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) {
//     // Return a future with a mock user credential
//     final mockUserCredential = MockUser();
//     return Future.value(mockUserCredential);
//   }

//   // Add more mock implementations of FirebaseAuth methods as needed
// }

// class MockUser extends Mock implements User {
//   // Implement any necessary User properties or methods for testing
// }

// class MockUserCredential extends Mock implements UserCredential {
//   // Implement any necessary UserCredential properties or methods for testing
// }
