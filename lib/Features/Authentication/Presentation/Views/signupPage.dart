import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Core/Widgets/birthDateTextField.dart';
import 'package:managemint/Core/Widgets/buttons.dart';
import 'package:managemint/Core/Widgets/emailTextField.dart';
import 'package:managemint/Core/Widgets/nameTextField.dart';
import 'package:managemint/Core/Widgets/passwordTextField.dart';
import 'package:managemint/Core/utils/styles.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/Widgets/haveAccount.dart';
import 'package:managemint/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel*/

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  static String id = 'SignupPage';
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final InputName userNameInput =
      InputName(label: 'User Name', InitialValue: '');
  final InputName firstNameInput =
      InputName(label: 'First Name', InitialValue: '');
  final InputName lastNameInput =
      InputName(label: 'Last Name', InitialValue: '');
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
      ),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
          ),
          body: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.h)),
                  Text(
                    'Signup',
                    style: Styles.headingText40,
                  ),
                  NameTextField(
                      i: userNameInput, NameController: userNameController),
                  NameTextField(
                      i: firstNameInput, NameController: firstNameController),
                  NameTextField(
                      i: lastNameInput, NameController: lastNameController),
                  Padding(padding: EdgeInsets.only(top: 30.h)),
                  EmailTextField(
                      emailCotroller: emailController, label: 'Email'),
                  Padding(padding: EdgeInsets.only(top: 15.h)),
                  Passwordtextfield(
                      passwordController: passwordController,
                      label: 'Password',
                      page: 'Signup'),
                  Padding(padding: EdgeInsets.only(top: 30.h)),
                  Buttons(
                    text: 'Register',
                    onPressedCallBack: () async {
                      /* if (formKey.currentState!.validate()) {
                            BlocProvider.of<SignupCubit>(context).SignUp(
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                birthDate: birthdateController.text);
                          }*/
                    },
                  ),
                  HaveAccount(have: 'Have', page: 'Login'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
