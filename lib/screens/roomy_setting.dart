import 'package:flutter/material.dart';

class RoomSettingsScreen extends StatelessWidget {
  const RoomSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color matches the image. 
      backgroundColor: const Color(0xFFFFFFFF), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title "Room Settings"
            const Text(
              'Room Settings',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            
            // "Members"
            Row(
              children: [
                const Text(
                  'Members',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // members list
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _MemberItem(
                      name: 'Member One',
                      isHost: true,
                    ),
                    _MemberItem(name: 'Member Two'),
                    _MemberItem(name: 'Member Three'),
                    _MemberItem(name: 'Member Four'),
                    _MemberItem(name: 'Member Five'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for a single member
class _MemberItem extends StatelessWidget {
  final String name;
  final bool isHost;

  const _MemberItem({
    required this.name,
    this.isHost = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // اcircular image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 15),
          
          // member name and host badg
          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isHost) ...[
                  const SizedBox(width: 8),
                  Container(

padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Host',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // add person icon
          const Icon(
            Icons.person_add_alt_outlined,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
