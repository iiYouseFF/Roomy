import 'package:flutter/material.dart';

class LoginRedirectText extends StatelessWidget {
  const LoginRedirectText({super.key, required this.text, required this.highlightedText, required this.directTo});

  final String text;
  final String highlightedText;
  final Widget directTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => directTo),
                );
          },
          child: Text(
            highlightedText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
