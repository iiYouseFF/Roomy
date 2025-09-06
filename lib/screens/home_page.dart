import 'dart:async';
import 'package:flutter/material.dart';
import 'package:roomy/screens/room_page.dart';
import 'package:roomy/widgets/custom_button.dart';
import 'package:roomy/widgets/custom_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomy/widgets/custom_challenge_card.dart';
import 'package:roomy/screens/user_profile.dart';
import 'package:roomy/screens/join_room.dart';
import 'package:roomy/screens/host_room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  List<dynamic> _joinedRooms = [];


  @override
  void initState() {
    super.initState();
    fetchJoinedRooms();
    getUserRooms();
  }

  Future<void> fetchJoinedRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';

    final response = await Supabase.instance.client
        .from('RoomMembers')
        .select('room_id, Rooms!inner(room_id, room_name, room_code)')
        .eq('user_id', userId);

    setState(() {
      _joinedRooms = response;
    });
    print(_joinedRooms);
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

  Future<List<Map<String, dynamic>>> getUserRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) {
      return [];
    }

    final response = await Supabase.instance.client
        .from('RoomMembers')
        .select('user_id, room_id, Rooms(*)') // نجيب بيانات الروم كاملة
        .eq('user_id', userId);

    debugPrint(response.toString());
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
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
                  CustomText(
                    text: username,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: SizedBox(
                width: 500,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                      text: "Join A Room",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Joinroom()),
                        );
                      },
                      backgroundColor: const Color(0xff1E88E5),
                      textColor: Colors.white,
                      width: 240,
                    ),
                    SizedBox(width: 20),
                    CustomButton(
                      text: "Host A Room",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Hostpage()),
                        );
                      },
                      backgroundColor: const Color(0xff1E88E5),
                      textColor: Colors.white,
                      width: 240,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
              CustomText( 
                text: "Your Challenges",
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              _joinedRooms.isEmpty
                  ? const Center(
                      child: Text("You haven't joined any rooms yet"),
                    )
                  : SizedBox(
                      width: 500,
                      height: 250,
                      child: ListView.builder(
                        itemCount: _joinedRooms.length,
                        itemBuilder: (context, index) {
                          final room = _joinedRooms[index];
                          return CustomChallengeCard(
                            title: room['Rooms']['room_name'],
                            description:
                                "Room Code: ${room['Rooms']['room_code']}",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Roompage(),
                                ),
                              );
                            },
                            buttonTitle: 'Enter Room',
                          );
                        },
                      ),
                    ),
            SizedBox(height: 30),
            CustomButton(text: "Reload", onPressed: fetchJoinedRooms, backgroundColor: Color(0xff1E88E5), textColor: Colors.white, width: 240)
          ],
        ),
      ),
    );
  }
}
