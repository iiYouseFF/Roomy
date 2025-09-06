import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomy/screens/room_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class Hostpage extends StatefulWidget {
  const Hostpage({super.key});

  @override
  State<Hostpage> createState() => _HostpageState();
}

class _HostpageState extends State<Hostpage> {
  String _selectedValue = "Main Task";
  final List<String> _items = ["Book", "Playlist", "Course"];
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _mainTaskController = TextEditingController();
  final TextEditingController _referenceLengthController =
      TextEditingController();
  final supabase = Supabase.instance.client;
  bool _isPublic = true;
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void dispose() {
    _roomNameController.dispose();
    _mainTaskController.dispose();
    _referenceLengthController.dispose();
    super.dispose();
  }

  String generateRoomCode() {
    final random = Random();
    // يولّد رقم من 6 أرقام (100000 إلى 999999)
    int code = 100000 + random.nextInt(900000);
    return code.toString();
  }

  Future<Set?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final username = prefs.getString('userName');
    if (userId == null || username == null) {
      return null;
    } else {
      return {userId, username};
    }
  }

  Future<String> generateUniqueRoomCode() async {
    String code;
    bool exists;

    do {
      code = generateRoomCode();
      exists = await isRoomCodeExists(code);
    } while (exists);

    return code;
  }

  Future<bool> isRoomCodeExists(String code) async {
    final response = await supabase
        .from('Rooms')
        .select()
        .eq('room_code', code);

    return response.isNotEmpty;
  }

  Future<void> createRoom() async {
    final userData = await getUserData();
    final roomCode = await generateUniqueRoomCode();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('roomCode', roomCode);

    if (userData == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }

    try {
      // 1. اعمل الروم
      final response = await supabase.from('Rooms').insert({
        'room_name': _roomNameController.text.trim(),
        'Task': _mainTaskController.text.trim(),
        'length_of_task': _referenceLengthController.text.trim(),
        'type_of_task': _selectedValue,
        'room_code': roomCode,
        'host_id': userData.elementAt(0),
        'host_name': userData.elementAt(1),
        'public': _isPublic,
      }).select();

      final room = response.first;
      final roomId = room['room_id']; // ID الروم اللي اتعمل

      // 2. ضيف الـ Creator في RoomMembers
      await supabase.from('RoomMembers').insert({
        'room_id': roomId,
        'user_id': userData.elementAt(0),
        'user_name': userData.elementAt(1),
      });

      // 3. روح على صفحة الروم
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => Roompage()));
    } catch (e) {
      print("Error creating room: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error creating room: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Host A Room!',
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 15),
            fields(
              nameOfTheField: "Room Name",
              controller: _roomNameController,
            ),
            fields(
              nameOfTheField: "Main Task",
              controller: _mainTaskController,
            ),
            Container(
              width: 500,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30), // Capsule shape
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedValue == "Main Task" ? null : _selectedValue,
                  hint: Text(
                    "Main Task",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: _items.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 66, 66, 66),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
            ),
            fields(
              nameOfTheField: "Refference length 30,10,..",
              controller: _referenceLengthController,
            ),
            GestureDetector(
              onTap: () async {
                // اختيار التاريخ
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  // اختيار الوقت
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    final DateTime finalDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );

                    setState(() {
                      _deadlineController.text = finalDateTime.toString();
                    });
                  }
                }
              },
              child: AbsorbPointer(
                // عشان يمنع الكتابة اليدوية
                child: fields(
                  nameOfTheField: "Deadline",
                  controller: _deadlineController,
                ),
              ),
            ),

            const SizedBox(height: 30),
            buttons(
              buttonName: "Create Room",
              color: "blue",
              context: context,
              onPressed: createRoom,
            ),
          ],
        ),
      ),
    );
  }
}

Widget fields({
  required nameOfTheField,
  required TextEditingController controller,
}) {
  return Container(
    width: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      color: Color.fromARGB(255, 221, 220, 220),
    ),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    child: TextField(
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color.fromARGB(255, 66, 66, 66),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: nameOfTheField,
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color.fromARGB(255, 142, 142, 142),
        ),
      ),
      controller: controller,
    ),
  );
}

Widget buttons({
  required String buttonName,
  required String color,
  required BuildContext context,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: color == "yellow" ? Colors.amber : Colors.blue,
    ),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 28),
      ),
    ),
  );
}
