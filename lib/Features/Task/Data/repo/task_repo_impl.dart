
import 'package:dartz/dartz.dart';

import '../../../../Core/Services/firebase_task_service.dart';
import '../../../../Core/errors/exceptions.dart';
import '../../../../Core/errors/failures.dart';
import '../../Domain/entity/task_entity.dart';
import '../../Domain/repo/task_repo.dart';
import '../model/task_model.dart';

class TaskRepoImpl extends TaskRepo {
  final FirebaseTaskService firebaseTaskServices;
  TaskRepoImpl({required this.firebaseTaskServices});


  @override
  Future<Either<Failure, String>> createTask(TaskEntity entity) async{
    try {
      final task = TaskModel.toFireStore(entity); // map TaskEntity to TaskModel
      await firebaseTaskServices.addTask(task); // pass model to service
      return right('Task created successfully');
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

   @override
  Future<Either<Failure, String>> updateTask(TaskEntity taskEntity)async {
     try {
       final task = TaskModel.toFireStore(taskEntity); // map TaskEntity to TaskModel
       await firebaseTaskServices.updateTask(task); // pass model to service
       return right('Task assigned  successfully');
     } on CustomExceptions catch (e) {
       return left(ServerFailure(e.message));
     }
  }


  @override
  Stream<Either<Failure, List<TaskEntity>>> getAllTasks() async* {
    try {
      print('Getting all tasks');
      yield* firebaseTaskServices.streamAllTasks().map((tasks){
        print('Task in repo $tasks');
       return right(tasks);

      });
      print('Getting all tasks');
    } catch (e) {
      yield left(ServerFailure('Failed to fetch tasks: $e'));
    }
  }
  @override
  Stream<Either<Failure, List<TaskEntity>>> getTasksByDevId(String devId) {
    try {
      return firebaseTaskServices.getTasksByDeveloper(devId).map(
            (tasks) => right<Failure, List<TaskEntity>>(tasks),
      );
    } on CustomExceptions catch (e) {
      return Stream.value(left<Failure, List<TaskEntity>>(ServerFailure(e.message)));
    } catch (e) {
      return Stream.value(left<Failure, List<TaskEntity>>(ServerFailure(e.toString())));
    }
  }



  }