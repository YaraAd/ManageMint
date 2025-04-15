// import 'package:flutter/material.dart';
// import 'package:managemint/Features/Task/Presentation/views/widgets/date.dart';
// import 'package:managemint/Features/Task/Presentation/views/widgets/task_inputField.dart';
//
// class AddTaskWidget extends StatefulWidget {
//   AddTaskWidget({super.key});
//
//   @override
//   State<AddTaskWidget> createState() => _AddTaskWidgetState();
// }
//
// class _AddTaskWidgetState extends State<AddTaskWidget> {
//   final TextEditingController _startDateController = TextEditingController();
//
//   final TextEditingController _endDateController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (context, setState) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery
//                   .of(context)
//                   .viewInsets
//                   .bottom,
//             ),
//             child: Container(
//               padding: EdgeInsets.all(20.w),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Add New Task',
//                     style: TextStyle(
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   TaskInputField(
//                     label: 'Task Name',
//                     onChanged: (value) => taskName = value,
//                   ),
//                   SizedBox(height: 15.h),
//                   DatePickerField(
//                       controller: _startDateController,
//                       labelText: 'Start Date',
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(
//                           const Duration(days: 365))),
//                   SizedBox(height: 15.h),
//                   DatePickerField(
//                       controller: _endDateController,
//                       labelText: 'End Date (optional)',
//                       firstDate: DateTime.now(),
//                       lastDate:
//                       DateTime.now().add(const Duration(days: 365 * 2))),
//                   SizedBox(height: 15.h),
//                   TaskInputField(
//                     label: "Description",
//                     onChanged: (value) => desc = value,
//                   ),
//                   SizedBox(height: 25.h),
//                   TaskButtons(
//                     context: context,
//                     onSave: () {
//                       if (taskName.isNotEmpty &&
//                           _startDateController.text.isNotEmpty &&
//                           _endDateController.text.isNotEmpty &&
//                           desc.isNotEmpty) {
//                         createTaskCubit.createTask(
//                             title: taskName,
//                             uid: widget.user.uid,
//                             des: desc,
//                             startDate: _startDateController.text,
//                             endDate: _endDateController.text,
//                             creationDate: DateTime.now().toString());
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//
//         }
//     );
//   }
// }
