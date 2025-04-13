import 'package:flutter/material.dart';
import 'package:managemint/Features/projectManager_Task/Presentation/views/widgets/date.dart';
import 'package:managemint/Features/projectManager_Task/Presentation/views/widgets/task.dart';
import 'package:managemint/Features/projectManager_Task/Presentation/views/widgets/task_buttons.dart';
import 'package:managemint/Features/projectManager_Task/Presentation/views/widgets/task_inputField.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  
  final List<Task> tasks = [];
  String _selectedTime = '';
  Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue, 
            onPrimary: Colors.white, 
            surface: Colors.white, 
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl, 
          child: child!,
        ),
      );
    },
  );

  if (pickedTime != null) {
   
    final timeText = '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';
    setState(() {
      _selectedTime = timeText;
    });
  }
}

  void _showAddTaskSheet(BuildContext context) {
    String taskName = '';
    String desc='';
 

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TaskInputField(
                  label: 'Task Name',
                  onChanged: (value) => taskName = value,
                ),
                const SizedBox(height: 15),
                DatePickerField(
                  controller: _startDateController,
                  labelText: 'Start Date',
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ),
                const SizedBox(height: 15),
                DatePickerField(
                  controller: _endDateController,
                  labelText: 'End Date (optional)',
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365*2)),
                ),
                TaskInputField(
                  label: "Description",
                   onChanged: (value)=> desc=value,
                   ),
                const SizedBox(height: 25),
                TaskButtons(
                  context: context,
                  onSave: () {
                    if (taskName.isNotEmpty && _startDateController.text.isNotEmpty &&_endDateController.text.isNotEmpty &&desc.isNotEmpty) {
                      setState(() {
                        tasks.add(Task(
                          task_name: taskName,
                          task_start_date: _startDateController.text,
                          task_end_date: _endDateController.text,
                           task_time: _selectedTime,
                          
                        ));
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 226, 232),
      appBar: AppBar(
        title: const Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 243, 226, 232),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet. Tap + to add one!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: tasks[index],
                );
              },
            ),
           
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskSheet(context),
        child: const Icon(Icons.add, size: 28),
        backgroundColor: Colors.blue,
      ),
    );
  }
}