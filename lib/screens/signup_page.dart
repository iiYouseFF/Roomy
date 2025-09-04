import 'package:flutter/material.dart';
import 'package:roomy/screens/login_page.dart';
import 'package:roomy/widgets/custom_text.dart';
import 'package:roomy/widgets/custom_textfield.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/widgets/custom_gender_selector.dart';
import 'package:roomy/widgets/custom_text_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController __usernameController = TextEditingController();
  final TextEditingController __ageController = TextEditingController();
  final TextEditingController __emailController = TextEditingController();
  final TextEditingController __passwordController = TextEditingController();
  String _selectedGender = 'Male';
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    __usernameController.dispose();
    __ageController.dispose();
    __emailController.dispose();
    __passwordController.dispose();
    super.dispose();
  }
  void signUp() async {
  if (__usernameController.text.isNotEmpty &&
      __ageController.text.isNotEmpty &&
      __emailController.text.isNotEmpty &&
      __passwordController.text.isNotEmpty) {
    try {
    final response = await supabase.from('Users').insert(
  {
    'UserName': __usernameController.text.trim(),
    'Age': int.tryParse(__ageController.text.trim()) ?? 0,
    'Email': __emailController.text.trim(),
    'Password': __passwordController.text.trim(),
    'Gender': _selectedGender,
  },
).select(); 
      final userId = response[0]['id'];

final prefs = await SharedPreferences.getInstance();
await prefs.setString('userId', userId.toString());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all the fields'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: 'Sign Up', fontSize: 32 , fontWeight: FontWeight.w400,),
            SizedBox(
              height: 85,
            ),
            CustomTextfield(hintText: 'Username' , controller: __usernameController),
            SizedBox(
              height: 15,
            ),
            CustomTextfield(hintText: 'Age', controller: __ageController),
            SizedBox(
              height: 15,
            ),
            GenderDropdown(value: _selectedGender),
            SizedBox(
              height: 15,
            ),
            CustomTextfield(hintText: 'Email' , controller: __emailController),
            SizedBox(
              height: 15,
            ),
            CustomTextfield(hintText: 'Password' , controller: __passwordController),
            SizedBox(height: 20,),
            CustomButton(text: 'Sign Up', onPressed: () {
              signUp();
            },
            backgroundColor: const Color(0xf3FFC107),
            textColor: Colors.black,
            width: 500
            ),
            SizedBox(height: 10,),
            LoginRedirectText(text: "Already have an account?", highlightedText: "Login", directTo: const LoginPage()),
          ],
        ),
      ),
    );
  }
}