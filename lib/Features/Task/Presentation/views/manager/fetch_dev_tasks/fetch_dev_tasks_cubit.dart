import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Domain/entity/task_entity.dart';

part 'fetch_dev_tasks_state.dart';

class FetchDevTasksCubit extends Cubit<FetchDevTasksState> {
  FetchDevTasksCubit() : super(FetchDevTasksInitial());
}
