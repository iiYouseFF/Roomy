import 'package:flutter/material.dart';
class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key, required this.value});

  final String value;

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String _selectedGender = 'Male';
  final List<String> genders = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: genders.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Select Gender',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
