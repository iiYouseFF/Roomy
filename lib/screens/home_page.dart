import 'dart:async';
import 'package:flutter/material.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/widgets/custom_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomy/widgets/custom_challenge_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      final response = await Supabase.instance.client
          .from('Users')
          .select()
          .eq('id', int.parse(userId));

      if (response.isNotEmpty) {
        setState(() {
          username = response[0]['UserName'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              width: 500,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xf3FFC107),
                borderRadius: BorderRadius.circular(100), 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: username, fontWeight: FontWeight.w800, fontSize: 20,),
                  SizedBox(width: 10,),
                  IconButton(icon: Icon(Icons.settings), onPressed: () {
                    // Handle settings action
                  }),
                ],
                
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(text: "Join A Room", 
                  onPressed: (){},
                  backgroundColor: const Color(0xff1E88E5), 
                  textColor: Colors.white,
                  width: 240,
                  ),
                  SizedBox(width: 20,),
                  CustomButton(text: "Host A Room", 
                  onPressed: (){},
                  backgroundColor: const Color(0xff1E88E5), 
                  textColor: Colors.white,
                  width: 240,
                  ),
                ],
              ),
            ),
              SizedBox(height: 30,),
              CustomText(text: "Your Challenges", fontSize: 16, fontWeight: FontWeight.w300,),
              SizedBox(height: 10,),
              CustomChallengeCard(title: 'ChallengeOne', description: 'description', onTap: (){}, buttonTitle: 'Continue!',),
              SizedBox(height: 10,),
              CustomText(text: "Community Challenges", fontSize: 16, fontWeight: FontWeight.w300,),
              SizedBox(height: 10,),
              CustomChallengeCard(title: 'ChallengeOne', description: 'description', onTap: (){}, buttonTitle: 'Join Now!')
          ],
        ),
      ),
    );
  }
}