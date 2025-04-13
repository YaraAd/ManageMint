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
import 'package:managemint/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 60.h)),

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
                                        email: emailController.text,
                                        password: passwordController.text);
                              }
                            },
                          ),
                          HaveAccount(have: 'Don\'t have', page: 'Signup'),
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
