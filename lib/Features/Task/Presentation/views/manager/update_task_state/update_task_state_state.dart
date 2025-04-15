part of 'update_task_state_cubit.dart';

@immutable
sealed class UpdateTaskStateState {}

final class UpdateTaskStateInitial extends UpdateTaskStateState {}
final class UpdateTaskStateLoading extends UpdateTaskStateState {}
final class UpdateTaskStateSuccess extends UpdateTaskStateState {
  final String successMessage;
  UpdateTaskStateSuccess({required this.successMessage});

}
final class UpdateTaskStateFailure extends UpdateTaskStateState {
  final String errorMessage;
  UpdateTaskStateFailure({required this.errorMessage});
}
