import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Core/Services/get_it_services.dart';
import 'package:managemint/Features/Authentication/Presentation/Manager/Cubits/signin_cubit/signin_cubit.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/signupPage.dart';
import 'package:managemint/Features/Task/Presentation/views/manager/projectManger_tasks_cubit/create_task_cubit.dart';
import 'package:managemint/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Core/Services/admin_auth_service.dart';
import 'Core/Services/firebase_task_service.dart';
import 'Features/Authentication/Domain/repo/auth_repo.dart';
import 'Features/Authentication/Presentation/Manager/Cubits/Signout_cubit/signout_cubit.dart';
import 'Features/Task/Data/repo/task_repo_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetit();
  final adminService = AdminService();
  await adminService.ensureAdminAccountExists();

  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CreateTaskCubit(
                    taskRepo: TaskRepoImpl(
                        firebaseTaskServices: FirebaseTaskService())
                ),
          ),
          BlocProvider(
            create: (context) => SignOutCubit(
              authRepo:  getIt<AuthRepo>(),
            ),
          ),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ManageMint',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: kButtonsColor,
              selectionColor: const Color.fromARGB(255, 174, 201, 255),
              selectionHandleColor: kButtonsColor,
            ),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            scaffoldBackgroundColor: const Color(0xFFF7F8FA),
          ),
          routes: {
            LoginPage.id: (context) => LoginPage(),
            SignupPage.id: (context) => SignupPage(),
          },
          home: child,
        );
      },
      child: LoginPage(),
    );
  }
}
