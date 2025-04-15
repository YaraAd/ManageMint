import 'package:flutter/material.dart';

class UserRoleSelector extends StatefulWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;

  const UserRoleSelector({
    Key? key,
    this.selectedRole,
    required this.onRoleSelected,
  }) : super(key: key);

  @override
  State<UserRoleSelector> createState() => _UserRoleSelectorState();
}

class _UserRoleSelectorState extends State<UserRoleSelector> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole;
  }

  void _onChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedRole = value;
      });
      widget.onRoleSelected(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your role:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: const Text('Project Manager'),
          leading: Radio<String>(
            value: 'Project Manager',
            groupValue: _selectedRole,
            onChanged: _onChanged,
          ),
        ),
        ListTile(
          title: const Text('Developer'),
          leading: Radio<String>(
            value: 'Developer',
            groupValue: _selectedRole,
            onChanged: _onChanged,
          ),
        ),
      ],
    );
  }
}
