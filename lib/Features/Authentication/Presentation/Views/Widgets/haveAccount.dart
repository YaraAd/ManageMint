import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/Features/Authentication/Presentation/Views/signupPage.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key, required this.have, required this.page});
  final String have;
  final String page;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 40.h)),
        Text(
          '$have an account ? ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        GestureDetector(
            onTap: () {
              page == 'Signup'
                  ? Navigator.pushNamed(context, SignupPage.id)
                  : Navigator.pop(context);
            },
            child: Text(
              '$page ',
              style: TextStyle(color: kButtonsColor),
            )),
      ],
    );
  }
}
