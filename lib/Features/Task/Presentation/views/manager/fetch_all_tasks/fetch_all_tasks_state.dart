part of 'fetch_all_tasks_cubit.dart';

@immutable
sealed class FetchAllTasksState {}

final class FetchAllTasksInitial extends FetchAllTasksState {}
final class FetchAllTasksLoading extends FetchAllTasksState {}
final class FetchAllTasksSuccess extends FetchAllTasksState {
  final List<TaskEntity> tasks;
  FetchAllTasksSuccess({required this.tasks});
}
final class FetchAllTasksFailure extends FetchAllTasksState {
  final String errorMessage;
  FetchAllTasksFailure({required  this.errorMessage});
}
