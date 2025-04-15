import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../../Core/errors/failures.dart';
import '../../../../Domain/entity/task_entity.dart';
import '../../../../Domain/repo/task_repo.dart';

part 'fetch_all_tasks_state.dart';

class FetchAllTasksCubit extends Cubit<FetchAllTasksState> {
  FetchAllTasksCubit(
  {required this.taskRepo}
      ) : super(FetchAllTasksInitial());
  TaskRepo taskRepo;
  StreamSubscription<Either<Failure, List<TaskEntity>>>? _taskSubscription;

  void getAllTasks() {
    emit(FetchAllTasksLoading());

    _taskSubscription?.cancel(); // cancel any previous subscription if it exists

    _taskSubscription = taskRepo.getAllTasks().listen((result) {
      result.fold(
            (failure) {
              emit(FetchAllTasksFailure(errorMessage: failure.message));
              },
            (tasks) {
              print('Tasks in cubit $tasks');
              emit(FetchAllTasksSuccess(tasks: tasks));
              },
      );
    });
  }


  void fetchDevTasks(String devId) {
    emit(FetchAllTasksLoading());

    // Cancel any previous subscription before creating a new one
    _taskSubscription?.cancel();

    _taskSubscription = taskRepo.getTasksByDevId(devId).listen((result) {
      result.fold(
            (failure) => emit(FetchAllTasksFailure(errorMessage: failure.message)),
            (devTasks) => emit(FetchAllTasksSuccess(tasks: devTasks)),
      );
    });
  }


  @override
  Future<void> close() {
    _taskSubscription?.cancel();
    return super.close();
  }

}
