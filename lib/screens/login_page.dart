import 'package:flutter/material.dart';
import 'package:roomy/screens/home_page.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/widgets/custom_text.dart';
import 'package:roomy/widgets/custom_text_button.dart';
import 'package:roomy/widgets/custom_textfield.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomy/screens/signup_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController __usernameController = TextEditingController();
  final TextEditingController __passwordController = TextEditingController();

  @override
  void dispose() {
    __usernameController.dispose();
    __passwordController.dispose();
    super.dispose();
  }

  Future<void> login(String userName, String password) async {
  final response = await Supabase.instance.client
      .from('Users')
      .select()
      .eq('UserName', userName)
      .eq('Password', password);

  if (response.isNotEmpty) {
    final user = response[0];
    final userId = user['id'];
    final username = user['UserName'];

    // خزن الـ userId في local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId.toString());
    await prefs.setString('userName', username.toString());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cand Find This User'),
          backgroundColor: Colors.red,
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
            SizedBox(height: 150),
            CustomText(text: 'Login Page', fontSize: 24, fontWeight: FontWeight.bold,),
            SizedBox(height: 150),
            CustomTextfield(hintText: 'User Name', controller: __usernameController,),
            SizedBox(height: 15,),
            CustomTextfield(hintText: 'Password', controller: __passwordController,),
            SizedBox(height: 10,),
            CustomButton(text: 'Login', onPressed: () {
              login(__usernameController.text, __passwordController.text);
            },
            backgroundColor: const Color(0xf3FFC107),
            textColor: Colors.white,
            width: 500,
            ),
            LoginRedirectText(text: "Don't have an account?", highlightedText: "Sign Up" , directTo: const SignupPage()),
          ],
        ),
      ),
    );
  }
}