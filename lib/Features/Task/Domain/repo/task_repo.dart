
import 'package:dartz/dartz.dart';

import '../../../../Core/errors/failures.dart';
import '../entity/task_entity.dart';

abstract class TaskRepo {
  Future<Either<Failure, String>> createTask( TaskEntity taskEntity);
  Future<Either<Failure, String>> updateTask ( TaskEntity taskEntity);
  Stream<Either<Failure, List<TaskEntity>>> getTasksByDevId (String devId);
  Stream<Either<Failure, List<TaskEntity>>> getAllTasks();
}


//Admin ->
// logged in ->
