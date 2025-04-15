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
import 'assigned_tasks_view.dart';
import 'manager/fetch_all_tasks/fetch_all_tasks_cubit.dart';
import 'manager/update_task_state/update_task_state_cubit.dart';

class Developer extends StatefulWidget {
  const Developer({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  State<Developer> createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAllTasksCubit(taskRepo:TaskRepoImpl(firebaseTaskServices: FirebaseTaskService()) )..getAllTasks(),
        ), BlocProvider(
          create: (context) => SignOutCubit(
    authRepo:  getIt<AuthRepo>(),
    ),
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
      child: BlocConsumer<SignOutCubit, SignOutState>(
  listener: (context, state) {
    if(state is SignOutLoading){
      isLoading = true;
    }
    if (state is SignOutSuccess) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())); // or use pushAndRemoveUntil
    } else if (state is SignOutFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed')),
      );
    }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF5F5),
        appBar: AppBar(

          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Sign out',
              onPressed: () {
                BlocProvider.of<SignOutCubit>(context)
                    .SignOut();
              },
            ),
          ],
          title: const Text(
            "Project Tasks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 22,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('View assigned tasks ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18
                        ),
                        ),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignedTasksView(
                            userEntity: widget.userEntity,
                          )));
                          //Navigate to assigned tasks screen
                        }, icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          if (!tasks[index].isAssigned) {
                            return NotassignedWidget(
                              status: tasks[index].status,
                              creationDate: tasks[index].creationDate,
                              desc: tasks[index].description,
                              task_end_date: tasks[index].endDate,
                              task_name: tasks[index].title,
                              task_start_date: tasks[index].startDate,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  // Update the database through Cubit
                                  context.read<UpdateTaskStateCubit>()
                                      .changeToInProgressState(
                                      tasks[index], widget.userEntity);
                                }
                              },
                            );
                          }
                          else {
                            //assigned widget
                           return   AssignedWidget(taskEntity: tasks[index]);
                          }
    }




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
),
    );
  }
}