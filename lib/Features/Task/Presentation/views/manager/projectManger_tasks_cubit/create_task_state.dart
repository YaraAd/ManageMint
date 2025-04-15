part of 'create_task_cubit.dart';

@immutable
sealed class ProjectManagerTasksState {}

final class ProjectManagerTasksInitial extends ProjectManagerTasksState {}

final class ProjectManagerTasksLoading extends ProjectManagerTasksState {}
final class ProjectManagerTasksSuccess extends ProjectManagerTasksState {
  final List<TaskEntity> tasks;
  ProjectManagerTasksSuccess({required this.tasks});

}

final class ProjectManagerTasksCreationSuccess extends ProjectManagerTasksState {
  final String successMessage;
  ProjectManagerTasksCreationSuccess({required this.successMessage});
}

final class ProjectManagerTasksFailure extends ProjectManagerTasksState {
  final String errorMessage;
  ProjectManagerTasksFailure({required this.errorMessage});
}
