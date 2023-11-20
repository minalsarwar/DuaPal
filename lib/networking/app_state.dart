import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ApplicationState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  // Future<void> signUpWithFirebase(String email, String password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     // Handle errors here (e.g., email is already in use, password is too weak)
  //     print('Firebase Authentication Error: ${e.message}');
  //   }
  // }

  Future<void> signUpWithFirebase(String email, String password) async {
    try {
      // Replace with your actual authentication code
      // For example, using Firebase Auth:
      // print(_auth.c);
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInAnonymously();
      // print("yeh print huha");
      // print(x);
      // Your additional logic after successful signup
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle errors here

      print('Firebase Authentication Error: ${e.code}, ${e.message}');
    } catch (e) {
      // Handle other errors
      print('Unexpected Error: $e');
    }
  }

  // Add other authentication methods like sign in and sign out as needed
  Future<void> signInWithFirebase(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      // await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle login errors here (e.g., invalid credentials)
      print('Firebase Authentication Error: ${e.message}');

      if (e.code == 'user-not-found') {
        // Handle "User not found" error
        print('User not found');
        throw 'User not found';
      } else if (e.code == 'wrong-password') {
        // Handle "Wrong password" error
        print('Wrong password');
        throw 'Wrong password';
      } else {
        // Handle other login errors
        print('An error occurred. Please try again.');
        throw 'An error occurred. Please try again.';
      }
    }
  }

  // final FirebaseAuth _auth2 = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<UserCredential?> signInwithGoogle() async {
  //   try {
  //     // Sign out of GoogleSignIn if a user is signed in
  //     // await _googleSignIn.signOut();

  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     // Return UserCredential
  //     return await _auth2.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     print('Error during Google sign-in: ${e.message}');
  //     throw e;
  //   }
  // }

  // Future<bool> signInWithFacebook(BuildContext context) async {
  //   try {
  //     final AccessToken? currentAccessToken =
  //         await FacebookAuth.instance.accessToken;

  //     if (currentAccessToken != null) {
  //       // Log out from the existing Facebook session
  //       await FacebookAuth.instance.logOut();
  //     }

  //     // Proceed with the Facebook login flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //     print(LoginResult);

  //     // Create a credential from the access token
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //     // Sign in with the Facebook credential
  //     final UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCredential(facebookAuthCredential);

  //     if (loginResult.status == LoginStatus.success) {
  //       print('Logged in!!!');
  //     }

  //     // Retrieve additional user data (optional)
  //     final userData =
  //         await FacebookAuth.instance.getUserData(fields: "email, name");
  //     print('Facebook User Data: $userData');

  //     // You can handle the retrieved user data here if needed.

  //     // Return true to indicate successful login
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     // Handle FirebaseAuth exceptions
  //     print('Firebase Auth Exception: ${e.message}');
  //     throw e;
  //   } on Exception catch (e) {
  //     // Handle other exceptions
  //     print('Unexpected Exception: $e');
  //     throw e;
  //   }
  // }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      // await _googleSignIn.signOut();

      // await FacebookAuth.instance.logOut();
      // print('User signed out successfully');

      // Navigate back to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }
}
