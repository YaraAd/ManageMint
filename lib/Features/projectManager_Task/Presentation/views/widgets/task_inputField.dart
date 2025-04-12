import 'package:flutter/material.dart';

class TaskInputField extends StatefulWidget {
  final String label;
  final Function(String)onChanged;

   TaskInputField({super.key, required this.label, required this.onChanged});

  @override
  State<TaskInputField> createState() => _TaskInputFieldState();
}

class _TaskInputFieldState extends State<TaskInputField> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
      onChanged: widget.onChanged,
    );
  }
}