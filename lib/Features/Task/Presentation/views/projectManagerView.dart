import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Features/Task/Data/repo/task_repo_impl.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/date.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/task.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/task_buttons.dart';
import 'package:managemint/Features/Task/Presentation/views/widgets/task_inputField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../Core/Services/firebase_task_service.dart';
import '../../../../constants.dart';
import '../../../Authentication/Presentation/Manager/Cubits/Signout_cubit/signout_cubit.dart';
import '../../../Authentication/Presentation/Views/loginPage.dart';
import '../../../Authentication/entity/user_entity.dart';
import '../../Domain/entity/task_entity.dart';
import 'manager/fetch_all_tasks/fetch_all_tasks_cubit.dart';
import 'manager/projectManger_tasks_cubit/create_task_cubit.dart';

class Projectmanagerview extends StatefulWidget {
   Projectmanagerview({  required this.user , super.key});
  UserEntity user;
  @override
  State<Projectmanagerview> createState() => _ProjectmanagerviewState();
}

class _ProjectmanagerviewState extends State<Projectmanagerview> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final List<Task> tasks = [];
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => CreateTaskCubit(taskRepo: TaskRepoImpl(firebaseTaskServices: FirebaseTaskService())),
),
    BlocProvider(
      create: (context) => FetchAllTasksCubit(taskRepo:TaskRepoImpl(firebaseTaskServices: FirebaseTaskService()) )..getAllTasks(),
    ),
  ],
  child:BlocConsumer<SignOutCubit, SignOutState>(
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
      return
        ModalProgressHUD(
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
              title: Text(
                "Project Space",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: const Color(0xFFFFF5F5),
            ),
            body: BlocBuilder<FetchAllTasksCubit, FetchAllTasksState>(
              builder: (context, state) {
                if (state is FetchAllTasksLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchAllTasksSuccess) {
                  final List<TaskEntity> tasks = state.tasks;
                  if (tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No tasks yet. Tap + to add one!',
                        style: TextStyle(
                            fontSize: 18.sp, color: Colors.black54),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Task(task: tasks[index],),
                        );
                      },
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddTaskSheet(context),
              backgroundColor: Colors.blue,
              child: Icon(Icons.add, size: 28.sp),
            ),
          ),
        );
    })

        );
    }
  void _showAddTaskSheet(BuildContext context) {
    String taskName = '';
    String desc = '';
    final createTaskCubit= context.read<CreateTaskCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add New Task',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TaskInputField(
                      label: 'Task Name',
                      onChanged: (value) => taskName = value,
                    ),
                    SizedBox(height: 15.h),
                    DatePickerField(
                        controller: _startDateController,
                        labelText: 'Start Date',
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                            const Duration(days: 365))),
                    SizedBox(height: 15.h),
                    DatePickerField(
                        controller: _endDateController,
                        labelText: 'End Date (optional)',
                        firstDate: DateTime.now(),
                        lastDate:
                        DateTime.now().add(const Duration(days: 365 * 2))),
                    SizedBox(height: 15.h),
                    TaskInputField(
                      label: "Description",
                      onChanged: (value) => desc = value,
                    ),
                    SizedBox(height: 25.h),
                    TaskButtons(
                      context: context,
                      onSave: () {
                        if (taskName.isNotEmpty &&
                            _startDateController.text.isNotEmpty &&
                            _endDateController.text.isNotEmpty &&
                            desc.isNotEmpty) {
                          createTaskCubit.createTask(
                              title: taskName,
                              des: desc,
                              startDate: _startDateController.text,
                              endDate: _endDateController.text,
                              creationDate: DateTime.now().toString());
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}