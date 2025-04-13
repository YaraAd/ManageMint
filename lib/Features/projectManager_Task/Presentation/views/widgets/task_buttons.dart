import 'package:flutter/material.dart';

class TaskButtons extends StatefulWidget {
  BuildContext context;
  Function() onSave;
  TaskButtons({super.key,required this.context,required this.onSave});

  @override
  State<TaskButtons> createState() => _TaskButtonsState();
}

class _TaskButtonsState extends State<TaskButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Save Task',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}