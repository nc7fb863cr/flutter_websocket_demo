import 'package:flutter/material.dart';

class OutlineInput extends StatelessWidget {
  OutlineInput({
    @required this.controller,
    @required this.icon,
    @required this.labelText,
    @required this.placeholder,
  });

  final String labelText;
  final String placeholder;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        style: TextStyle(fontSize: 18),
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            labelText: this.labelText,
            hintText: this.placeholder,
            prefixIcon: Icon(this.icon, size: 24),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
