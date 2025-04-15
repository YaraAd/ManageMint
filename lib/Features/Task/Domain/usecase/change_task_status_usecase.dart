
import 'package:dartz/dartz.dart';

import '../../../../Core/errors/failures.dart';
import '../../../Authentication/entity/user_entity.dart';
import '../../TaskState/task_state.dart';
import '../entity/task_entity.dart';
import '../repo/task_repo.dart';


class ChangeTaskStatusUseCase {
  TaskRepo taskRepo;
  ChangeTaskStatusUseCase({required this.taskRepo});

   Future<Either<Failure, String>> call(TaskEntity task, TaskState newState, UserEntity userEntity)async {
    TaskEntity updatedTask =  task.copyWith(status: newState.statusLabel , isAssigned: true, assignedTo: userEntity.userName, devId: userEntity.uid);
    return await taskRepo.updateTask(updatedTask); ////////////////////////////
  }
}