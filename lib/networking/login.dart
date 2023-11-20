import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailTooLong = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void validateEmail(String value) {
    if (value.length > 50) {
      setState(() {
        isEmailTooLong = true;
      });
    } else {
      setState(() {
        isEmailTooLong = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   child: Image.asset(
            //     'android/assets/asset1.jpg',
            //     fit: BoxFit.cover,
            //   ),
            // ),
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
                    'Log In',
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: isEmailTooLong ? Colors.red : Colors.black,
                        width: 1.0,
                      ),
                    ),
                    errorText: isEmailTooLong
                        ? 'Email can only be of 50 characters'
                        : null,
                  ),
                  onChanged: (value) {
                    validateEmail(value);
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${emailController.text.length}/50',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromARGB(255, 196, 189, 189)
                        : Color.fromARGB(226, 86, 86, 86),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  maxLength: 20,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 118, 181, 197),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Sign In',
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
                  Text("Don't have an account yet? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign Up!",
                      style: TextStyle(
                        color: Colors.purple[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Forgot Password?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
