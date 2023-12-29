import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/networking/auth/app_state.dart';

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authServiceProvider);
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);
    final confirmPasswordController =
        ref.read(confirmPasswordControllerProvider);
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
    final doPasswordsMatch = ref.watch(doPasswordsMatchProvider);
    final isEmailValid = ref.watch(isEmailValidProvider);

    void validateEmail(String value) {
      // Check if the email is valid
      if (!value.isValidEmail()) {
        // Update the state to reflect the email error
        ref.read(isEmailValidProvider.notifier).state = false;
      } else {
        ref.read(isEmailValidProvider.notifier).state = true;
      }
    }

    void checkPasswordMatch() {
      final bool passwordsMatch =
          passwordController.text == confirmPasswordController.text;

      // Update the state to reflect whether passwords match
      ref.read(doPasswordsMatchProvider.notifier).state = passwordsMatch;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.network(
                'https://img.freepik.com/free-vector/hand-drawn-flat-design-tasbih-illustration_23-2149275536.jpg?w=740&t=st=1700404835~exp=1700405435~hmac=c205e72af8ea323f74f11d8f0bfaf195f35d55dda2dabac58e52fbb28e1be16a',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  maxLength: 50,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    // Display an error message if the email is invalid
                    errorText: isEmailValid ? null : 'Invalid email address',
                  ),
                  onChanged: (value) {
                    validateEmail(value);
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    TextField(
                      maxLength: 20,
                      obscureText: !isPasswordVisible,
                      controller: ref.read(passwordControllerProvider),
                      onChanged: (password) {
                        // Call the function to check password match
                        checkPasswordMatch();
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 62, 61, 61),
                          ),
                          onPressed: () {
                            ref.read(isPasswordVisibleProvider.notifier).state =
                                !ref
                                    .read(isPasswordVisibleProvider.notifier)
                                    .state;
                          },
                        ),
                      ),
                    ),
                    TextField(
                      maxLength: 20,
                      obscureText: !isPasswordVisible,
                      controller: ref.read(confirmPasswordControllerProvider),
                      onChanged: (confirmPassword) {
                        // Call the function to check password match
                        checkPasswordMatch();
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 62, 61, 61),
                          ),
                          onPressed: () {
                            ref.read(isPasswordVisibleProvider.notifier).state =
                                !ref
                                    .read(isPasswordVisibleProvider.notifier)
                                    .state;
                          },
                        ),
                      ),
                    ),

                    // Show an error message if passwords don't match
                    if (ref.read(passwordControllerProvider).text.isNotEmpty &&
                        ref
                            .read(confirmPasswordControllerProvider)
                            .text
                            .isNotEmpty &&
                        !doPasswordsMatch)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Passwords do not match!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        // Passwords match, proceed with registration
                        await auth.signUpWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );

                        if (FirebaseAuth.instance.currentUser != null) {
                          // If signed up, navigate to the login screen
                          Navigator.pushNamed(context, '/login');
                        } else {
                          // If not signed up, print a message (you can replace this with your desired action)
                          print('Sign up unsuccessful');
                        }
                      } else {
                        // Passwords do not match, show an error or take appropriate action
                        print('Passwords do not match');
                      }
                    } catch (e) {
                      // Handle exceptions here, e.g., display an error message using SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Sign up failed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Text("Have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.purple[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
