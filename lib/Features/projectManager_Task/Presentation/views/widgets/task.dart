import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  String task_name;
  String task_start_date;
  String task_end_date;
  String task_time;
  
   Task({super.key,required this.task_name,required this.task_start_date,required this.task_end_date,required this.task_time});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  

  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
                  height: 160,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>
                      (
                        title:Text(
                          widget.task_name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,

                          ),
                          ),
                        value: "t1",
                        groupValue: _selectedOption,
                         onChanged: (value){
                          setState((){
                            _selectedOption=value;
                          });
                         }
                         ),
                         Padding(
                          padding:EdgeInsets.only(left: 70),
                           child: Text('start date:${widget.task_start_date}'
                           ,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            ),
                         ),
                         Padding(
                          padding:EdgeInsets.only(left: 70),
                           child: Text('end date:${widget.task_end_date}'
                           ,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            ),
                         ),
                         Padding(
                          padding:EdgeInsets.only(left: 70),
                           child: Text('time: ${widget.task_time}'
                           ,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            ),
                         ),
                     
                    ],
                    
                  ),
            
                ),
          );
  }
}