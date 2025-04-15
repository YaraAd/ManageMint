
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:managemint/Features/Task/Domain/entity/task_entity.dart';

class TaskModel extends TaskEntity{

  TaskModel({required super.taskId, required super.title, required super.description,
    required super.creationDate,required super.endDate,required super.startDate,
    required super.assignedTo,required super.status,
     required super.devId, required super.isAssigned
  });

  factory TaskModel.fromFireStore(Map<String, dynamic> data, String id) {
    return TaskModel(
       taskId: data['taskId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      creationDate: data['creationDate'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      assignedTo: data['assignedTo'] ?? '',
      devId:  data['devId'] ?? '',
      status: data['status'] ?? 'Open',
      isAssigned: data['isAssigned'] ?? false
    );
  }

  static Map<String, dynamic> toFireStore(TaskEntity entity) {
    return {
      'taskId': entity.taskId,
      'title': entity.title,
      'description': entity.description,
      'creationDate': entity.creationDate,
      'startDate': entity.startDate,
      'endDate': entity.endDate,
      'assignedTo': entity.assignedTo,
      'status': entity.status,
      'isAssigned' : entity.isAssigned,
      'devId' : entity.devId
    };
  }

}
