import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Features/Task/Domain/repo/task_repo.dart';
import 'package:managemint/Features/Task/Domain/usecase/change_task_status_usecase.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/assigned_widget.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/completed_task_card.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/inprogress_task_card.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/not_assigned_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../Core/Services/firebase_task_service.dart';
import '../../../../Core/Services/get_it_services.dart';
import '../../../../constants.dart';
import '../../../Authentication/Domain/repo/auth_repo.dart';
import '../../../Authentication/Presentation/Manager/Cubits/Signout_cubit/signout_cubit.dart';
import '../../../Authentication/Presentation/Views/loginPage.dart';
import '../../../Authentication/entity/user_entity.dart';
import '../../Data/repo/task_repo_impl.dart';
import '../../Domain/entity/task_entity.dart';
import 'manager/fetch_all_tasks/fetch_all_tasks_cubit.dart';
import 'manager/update_task_state/update_task_state_cubit.dart';

class AssignedTasksView extends StatefulWidget {
  const AssignedTasksView({super.key, required this.userEntity});

  final UserEntity userEntity;
  @override
  State<AssignedTasksView> createState() => _AssignedTasksViewState();
}

class _AssignedTasksViewState extends State<AssignedTasksView> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAllTasksCubit(taskRepo:TaskRepoImpl(firebaseTaskServices: FirebaseTaskService()) )..fetchDevTasks(widget.userEntity.uid),
        ),
        BlocProvider(
          create: (context) =>
              UpdateTaskStateCubit(
                  changeTaskStatusUseCase: ChangeTaskStatusUseCase(
                      taskRepo: TaskRepoImpl(
                          firebaseTaskServices: FirebaseTaskService()
                      ))
              ),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF5F5),
        appBar: AppBar(

          title: const Text(
            "Assigned Tasks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFFFFF5F5),
        ),
        body:
        BlocBuilder<FetchAllTasksCubit, FetchAllTasksState>(
          builder: (context, state) {
            if (state is FetchAllTasksLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchAllTasksSuccess) {
              final List<TaskEntity> tasks = state.tasks;
              if (tasks.isEmpty) {
                return Center(
                  child: Text(
                    'No tasks yet.',
                    style: TextStyle(fontSize: 18.sp, color: Colors.black54),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                           if (tasks[index].status == 'In Progress') {
                            return InProgressTaskCard(
                              taskEntity: tasks[index],
                              onChanged: (bool? value) {
                                if (value == true) {
                                  // Update the database through Cubit
                                  context.read<UpdateTaskStateCubit>()
                                      .changeToCompleteState(
                                      tasks[index], widget.userEntity);
                                }
                              },
                            );
                          }
                          else if (tasks[index].status == 'Completed') {
                            return CompletedTaskCard(
                              taskEntity: tasks[index],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (state is FetchAllTasksFailure) {
              return Center(
                child: Text(
                    state.errorMessage
                ),
              );
            }

            else {
              return Center(
                child: Text(
                    'Something went wrong'
                ),
              );
            }
          },
        ),
      ),
    );
  }
}