import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Features/Task/Data/model/task_model.dart';
import '../../Features/Task/Domain/entity/task_entity.dart';


class FirebaseTaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String tasksCollection = 'tasks';

  // 1. Add a task
  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      // Create a new doc with auto-generated ID
      final docRef = _firestore.collection(tasksCollection).doc();

      // Add the taskId to the task map
      final taskWithId = {
        ...task,
        'taskId': docRef.id,
      };

      // Set the document with the new data
      await docRef.set(taskWithId);
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }
  Future<void> updateTask(Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection(tasksCollection).doc(updatedData['taskId']).update(updatedData);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // 2. Get all tasks
  Stream<List<TaskEntity>> streamAllTasks() {
    return _firestore
        .collection(tasksCollection)
        .snapshots()
        .handleError((error) {
      // Optional: Log or handle the error outside the stream transformation
      print('Firestore stream error: $error');
    })
        .map((snapshot) {
      try {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          print('Data in firebase $data');
          return TaskModel.fromFireStore(data, doc.id);
        }).toList();
      } catch (e, stackTrace) {
        print('Error parsing task documents: $e');
        print(stackTrace);
        return <TaskEntity>[]; // Return empty list or rethrow if needed
      }
    });
  }
  Stream<List<TaskEntity>> getTasksByDeveloper(String devId) {
    try {
      return _firestore
          .collection(tasksCollection)
          .where('devId', isEqualTo: devId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        return TaskModel.fromFireStore(data, doc.id);
      }).toList());
    } catch (e) {
      // Optional: You can log or rethrow if needed, but avoid throwing inside a stream directly
      print('Failed to fetch developer tasks: $e');
      return const Stream.empty();
    }
  }





}
