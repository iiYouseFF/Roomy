import 'package:flutter/material.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/screens/login_page.dart';
import 'package:roomy/widgets/custom_text.dart';
import 'package:roomy/screens/signup_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 225,
            ),
            CustomText(text: 'Welcome to Roomy!', fontSize: 32, fontWeight: FontWeight.bold),
            SizedBox(
              height: 155,
            ),
            CustomButton(
              text: 'Login',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              backgroundColor: const Color(0xf3FFC107),
              textColor: Colors.black,
              width: 500,
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
               Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              backgroundColor: const Color(0xf3FFC107),
              textColor: Colors.black,
              width: 500,
            ),
          ],
        ),
      ),
    );
  }
}