/*Yara Adel*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Core/Services/get_it_services.dart';
import 'package:managemint/Core/Widgets/buttons.dart';
import 'package:managemint/Core/Widgets/passwordTextField.dart';
import 'package:managemint/Core/Widgets/userNameTextfield.dart';
import 'package:managemint/Core/utils/styles.dart';
import 'package:managemint/Features/Authentication/Domain/repo/auth_repo.dart';
import 'package:managemint/Features/Authentication/Presentation/Manager/Cubits/signin_cubit/signin_cubit.dart';
import 'package:managemint/Features/Authentication/Presentation/Manager/Cubits/signin_cubit/signin_state.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/Widgets/haveAccount.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/signupPage.dart';
import 'package:managemint/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Task/Presentation/views/developerView.dart';
import '../../../Task/Presentation/views/projectManagerView.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        body: Builder(builder: (context) {
          return BlocConsumer<SigninCubit, SigninState>(
            listener: (BuildContext context, state) {
              if (state is SigninSuccess) {
                 if(state.userEntity.role == 'Project Manager'){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>  Projectmanagerview(user: state.userEntity,)));

                 }else if (state.userEntity.role == 'Developer'){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>  Developer(userEntity:  state.userEntity,)));

                 }
                 else {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>  SignupPage()));

                 }
              } else if (state is SigninFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ));
                isLoading = false;
              } else if (state is SigninLoading) {
                isLoading = true;
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: isLoading!,
                progressIndicator: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
                ),
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 120.h)),

                          Text(
                            'Login',
                            style: Styles.headingText40,
                          ),
                          //Padding(padding: EdgeInsets.only(top: 40.h)),
                          UserNameTextField(
                              emailCotroller: emailController,
                              label: 'Email or username'),
                          Passwordtextfield(
                            passwordController: passwordController,
                            label: 'Password',
                            page: 'Login',
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.h)),
                          Buttons(
                            text: 'Login',
                            onPressedCallBack: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<SigninCubit>(context)
                                    .createUserwithEmailandPassword(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim());
                              }
                            },
                          ),
                         // HaveAccount(have: 'Don\'t have', page: 'Signup'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
