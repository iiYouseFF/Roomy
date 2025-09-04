import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Roompage.dart';

class Joinroom extends StatefulWidget {
  const Joinroom({super.key});

  @override
  State<Joinroom> createState() => _JoinroomState();
}

class _JoinroomState extends State<Joinroom> {
  TextEditingController controller = TextEditingController();
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
          Pincode(context, controller),
          SizedBox(height: 2),
          Joinbutton(context),
        ],
      ),
    );
  }
}

Widget Pincode(BuildContext context, TextEditingController controller) {
  String currentPin = "";
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
          onChanged: ((value) {
            currentPin = value;
          }),
          onCompleted: (value) {
            ///////////////////////////////////////
            //هنا لازم تعمل طريقة للفاليديشن عشان هو حتي لو محطتش الكود بيدخل
          },
        ),
      ),
    ],
  );
}

//open me --في مشكلة جوا
Widget Joinbutton(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24),
    child: MaterialButton(
      color: Colors.blue,
      height: 52,
      minWidth: 355,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(26),
      ),
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => Roompage()));
      },
      child: Text(
        "Join!",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 28),
      ),
    ),
  );
}
