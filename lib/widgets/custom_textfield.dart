import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextfield({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8E8E8E),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color(0xFFDCDCDC),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}