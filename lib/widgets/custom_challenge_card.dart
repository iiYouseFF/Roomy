import 'package:flutter/material.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/widgets/custom_text.dart';

class CustomChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final String buttonTitle;

  const CustomChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.buttonTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xaaDDDCDC),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: title, fontSize: 32, fontWeight: FontWeight.bold,),
          SizedBox(height: 10,),
          CustomText(text: description , fontSize: 28, fontWeight: FontWeight.w500,),
          SizedBox(height: 10,),
          CustomButton(text: buttonTitle, onPressed: onTap, backgroundColor: const Color(0xff1E88E5), textColor: Colors.white, width: 400)
        ],
      ),
    );
  }
}