import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomy/screens/room_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roomy/widgets/custom_button.dart';

class Joinroom extends StatefulWidget {
  const Joinroom({super.key});

  @override
  State<Joinroom> createState() => _JoinroomState();
}

class _JoinroomState extends State<Joinroom> {
  TextEditingController controller = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> joinRoom(String roomCode) async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
  final userName = prefs.getString('userName');

  if (userId == null || userName == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User not logged in")),
    );
    return;
  }

  final room = await supabase
      .from('Rooms')
      .select()
      .eq('room_code', roomCode)
      .maybeSingle();

  if (room == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Room not found")),
    );
    return;
  }
  await supabase.from('RoomMembers').insert({
    'room_id': room['room_id'],
    'user_id': userId,
    'user_name': userName,
  });

  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => Roompage()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Join A ROOM!",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Enter The Room Code",
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          SizedBox(height: 12),
          pincode(context, controller),
          SizedBox(height: 2),
          CustomButton(text: 'Join!', onPressed: () => joinRoom(controller.text), backgroundColor:const Color(0xff1E88E5) , textColor: Colors.white, width: 500)
        ],
      ),
    );
  }
}

Widget pincode(BuildContext context, TextEditingController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 38),
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          controller: controller,
          cursorHeight: 19,
          enableActiveFill: true,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          pinTheme: PinTheme(
            activeColor: Colors.lightBlue,
            shape: PinCodeFieldShape.box,
            fieldHeight: 50,
            fieldWidth: 42,
            inactiveColor: const Color.fromARGB(255, 255, 252, 252),
            selectedColor: const Color.fromARGB(255, 60, 161, 244),
            activeFillColor: Colors.blue,
            selectedFillColor: Colors.blue,
            inactiveFillColor: const Color.fromARGB(450, 217, 217, 217),
            borderWidth: .2,

            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );
}


