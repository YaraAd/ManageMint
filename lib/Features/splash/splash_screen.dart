// import 'package:flutter/material.dart';
// import 'package:managemint/Core/Services/auth_service.dart';
// import 'package:managemint/Features/Authentication/Presentation/Views/login_page.dart';
// import 'package:managemint/Features/Authentication/entity/user_entity.dart';
// import 'package:managemint/Features/Task/Presentation/views/developerView.dart';
// import 'package:managemint/Features/Task/Presentation/views/projectManagerView.dart';
//
// import '../../Core/Services/firebase_auth_services.dart';
// import '../Authentication/Presentation/Views/loginPage.dart';
// import '../Authentication/Presentation/Views/signupPage.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   final FirebaseAuthServices _authService = FirebaseAuthServices();
//
//   @override
//   void initState() {
//     super.initState();
//     _navigateBasedOnRole();
//   }
//
//   void _navigateBasedOnRole() async {
//     await Future.delayed(Duration(seconds: 2)); // splash delay
//     final user = _authService.getCurrentUser();
//     //final userDate = _authService.getUserDate(user.uid);
//
//     if (user != null) {
//       final role = await _authService.getCurrentUserRole();
//       if (role == 'Admin') {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) =>  SignupPage()));
//       } else if (role == 'Project Manager') {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (_) => Projectmanagerview(user:UserEntity(uid: user.uid, email: user.email, password: user.uid, userName: userName, role: role))));
//       } else if (role == 'Developer') {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => const Developer(userEntity: null,)));
//       } else {
//         // Default fallback
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => const LoginPage()));
//       }
//     } else {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const LoginPage()));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
