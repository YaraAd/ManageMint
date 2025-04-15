import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../Authentication/entity/user_entity.dart';
import '../../../../Domain/entity/task_entity.dart';
import '../../../../Domain/usecase/change_task_status_usecase.dart';
import '../../../../TaskState/completed_state.dart';
import '../../../../TaskState/in_progress_state.dart';

part 'update_task_state_state.dart';

class UpdateTaskStateCubit extends Cubit<UpdateTaskStateState> {
  UpdateTaskStateCubit(
  {
     required this.changeTaskStatusUseCase
}
      ) : super(UpdateTaskStateInitial());
  ChangeTaskStatusUseCase changeTaskStatusUseCase;


  ///TODO:: assign dev name, devId , isAssign true
  Future<void> changeToInProgressState(TaskEntity taskEntity, UserEntity userEntity ) async {
    emit(UpdateTaskStateLoading());
    final result = await  changeTaskStatusUseCase.call(taskEntity, InProgressState(), userEntity);
    result.fold((Failure) => emit(UpdateTaskStateFailure(errorMessage: Failure.message)),
            (successMessage) => emit(UpdateTaskStateSuccess(successMessage: successMessage)));
  }
 Future<void> changeToCompleteState(TaskEntity taskEntity,  UserEntity userEntity  ) async {
    emit(UpdateTaskStateLoading());
    final result = await  changeTaskStatusUseCase.call(taskEntity, CompletedState(), userEntity);
    result.fold((Failure) => emit(UpdateTaskStateFailure(errorMessage: Failure.message)),
            (successMessage) => emit(UpdateTaskStateSuccess(successMessage: successMessage)));
  }

}
