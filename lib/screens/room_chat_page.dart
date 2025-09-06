import 'package:flutter/material.dart'; 


class RoomChatScreen extends StatelessWidget {
  const RoomChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Header (Back button, Title, Menu button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room Name',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Challenge',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Chat content area (empty)
              const Expanded(
                child: Center(
                  child: Text(
                    'ابدأ المحادثة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),

              // Chat input field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.black),
                      onPressed: () {
                        // Action to send message
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
