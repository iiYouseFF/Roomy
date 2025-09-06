import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:roomy/screens/room_chat_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Roompage extends StatefulWidget {
  @override
  State<Roompage> createState() => _RoompageState();
}

class _RoompageState extends State<Roompage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic> _roomData = {};

  
  @override
  void initState() {
    super.initState();
    getRoomData();
  }

  


  Future<void> getRoomData() async {
    final prefs = await SharedPreferences.getInstance();
    String roomCode = prefs.getString('roomCode') ?? '';
    try {
      final response = await Supabase.instance.client
          .from('Rooms')
          .select()
          .eq('room_code', roomCode)
          .single();

      setState(() {
        _roomData = response;
      });
    } catch (e) {
      print('Error fetching room data: $e');
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoomChatScreen()),
          );
        },
        shape: CircleBorder(),

        backgroundColor: Colors.blue,
        child: Icon(Icons.chat_bubble, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Titles(titel: "${_roomData['room_name']}", font: "bold"),
          Titles(titel: "${_roomData['Task']}", font: "normal"),
          Titles(titel: "${_roomData['room_code']}", font: "normal"),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Time Left 50%",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ProgressBar(color: "green", percent: .5),
          ZeroToHUNdred(),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Task Progress 75%",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ProgressBar(color: "amber", percent: .75),
          ZeroToHUNdred(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Tasks",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Row(
            children: [
              check(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(
                  "Task 1",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              check(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(
                  "Task 2",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              check(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(
                  "Task 3",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              check(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(
                  "Task 4",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

Widget Titles({required String titel, required String font}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Text(
      "$titel",
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: font == "bold" ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget ProgressBar({required String color, required double percent}) {
  return LinearPercentIndicator(
    barRadius: Radius.circular(9),
    lineHeight: 10,
    progressColor: color == "green" ? Colors.green : Colors.amber,
    percent: percent,
  );
}

Widget ZeroToHUNdred() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("0%"), Text("100%")],
    ),
  );
}

class check extends StatefulWidget {
  const check({super.key});

  @override
  State<check> createState() => _checkState();
}

class _checkState extends State<check> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: IconButton(
            onPressed: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            icon: Icon(
              size: 35,
              isChecked ? Icons.check_box_sharp : Icons.check_box_outline_blank,
              color: isChecked ? Colors.green : null,
            ),
          ),
        ),
      ],
    );
  }
}
