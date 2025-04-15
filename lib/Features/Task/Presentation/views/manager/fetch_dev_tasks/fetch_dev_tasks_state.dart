part of 'fetch_dev_tasks_cubit.dart';

@immutable
sealed class FetchDevTasksState {}

final class FetchDevTasksInitial extends FetchDevTasksState {}
final class FetchDevTasksLoading extends FetchDevTasksState {}
final class FetchDevTasksSuccess extends FetchDevTasksState {
  final List<TaskEntity> devTasks;
  FetchDevTasksSuccess({required this.devTasks});

}
final class FetchDevTasksFailure extends FetchDevTasksState {
  final String errorMessage;
  FetchDevTasksFailure({required this.errorMessage});
}
