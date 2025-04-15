import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Domain/entity/task_entity.dart';

class Task extends StatefulWidget {
  final TaskEntity task;
 // final VoidCallback onDelete;

  const Task(
      {super.key,
        required this.task
      });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(80),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color:   getStatusColor(widget.task.status),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child:  Text(
                            widget.task.status,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 17),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    _buildDateInfo(Icons.calendar_today, "Start Date",
                      widget.task.startDate,),
                    const SizedBox(height: 10),
                    _buildDateInfo(Icons.event_available, "End Date",
                      widget.task.endDate,),
                    const SizedBox(height: 10),
                    _buildDateInfo(
                        Icons.create, "Created",  widget.task.creationDate),

                    const SizedBox(height: 10),
                    widget.task.isAssigned ?
                    Row(
                      children: [
                        Icon(Icons.person,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),



                             Text(
                              "Assigned to : ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                                                     ),
                             Text(
                               widget.task.assignedTo,
                               style: const TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black87,
                               ),
                             ),


                      ],
                    ) : SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    }
  Widget _buildDateInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  Color getStatusColor(String state){
    if(state == 'Open'){
      return Colors.blueAccent;
    }else if(state == 'In Progress'){
      return  Colors.orangeAccent;
    }else {
      return Colors.greenAccent;
    }
  }
}