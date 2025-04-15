import 'package:bloc/bloc.dart';
import 'package:managemint/Features/Task/Domain/entity/task_entity.dart';
import 'package:meta/meta.dart';
import '../../../../Domain/repo/task_repo.dart';
part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<ProjectManagerTasksState> {
  TaskRepo taskRepo;

  CreateTaskCubit({required this.taskRepo})
      : super(ProjectManagerTasksInitial());

  Future<void> createTask(
      {required String title , required String des, required String startDate, required String endDate, required String creationDate, }) async {
    emit(ProjectManagerTasksLoading());
    final result = await  taskRepo.createTask(TaskEntity( title: title, assignedTo: '',  description: des, startDate: startDate, endDate: endDate, creationDate: creationDate));
    result.fold((Failure) => emit(ProjectManagerTasksFailure(errorMessage: Failure.message)),
            (successMessage) => emit(ProjectManagerTasksCreationSuccess(successMessage: successMessage)));
  }

}
