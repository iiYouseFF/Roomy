import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hostpage extends StatefulWidget {
  const Hostpage({super.key});

  @override
  State<Hostpage> createState() => _HostpageState();
}

class _HostpageState extends State<Hostpage> {
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
            Fields(nameOfTheField: "Room Name"),
            Fields(nameOfTheField: "Number of Members"),
            Fields(nameOfTheField: "Main Task"),
            Buttons(buttonName: "Create!", color: "blue", context: context),
            Buttons(
              buttonName: "Invite Friends",
              color: "yellow",
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}

Widget Fields({required nameOfTheField}) {
  return Container(
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
    ),
  );
}

Widget Buttons({
  required String buttonName,
  required String color,
  required BuildContext context,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: color == "yellow" ? Colors.amber : Colors.blue,
    ),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    child: TextButton(
      onPressed: () {
        if (buttonName == "Create") {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => RoomPage()));
        } else {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Profile()));
        }
      },
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 28),
      ),
    ),
  );
}
