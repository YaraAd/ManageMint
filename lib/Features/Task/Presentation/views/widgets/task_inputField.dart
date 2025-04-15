import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskInputField extends StatefulWidget {
  final String label;
  final Function(String) onChanged;

  const TaskInputField(
      {super.key, required this.label, required this.onChanged});

  @override
  State<TaskInputField> createState() => _TaskInputFieldState();
}

class _TaskInputFieldState extends State<TaskInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: Colors.black
      ),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color:  Colors.black,
          ),
          border: const OutlineInputBorder(),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
        onChanged: widget.onChanged,
        );
    }
}