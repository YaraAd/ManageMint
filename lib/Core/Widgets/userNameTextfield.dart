import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class UserNameTextField extends StatefulWidget {
  const UserNameTextField(
      {super.key, required this.label, required this.emailCotroller});
  final TextEditingController emailCotroller;
  final String label;
  @override
  State<UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<UserNameTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        child: SizedBox(
          width: 290.w,
          child: TextFormField(
            controller: widget.emailCotroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email or username';
              }
              return null;
            },
            style: TextStyle(
                color: Colors.black, fontSize: 15.sp, fontFamily: 'bold'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0.h,
                horizontal: 9.0.w,
              ),
              border: const OutlineInputBorder(),
              labelText: widget.label,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kButtonsColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kButtonsColor,
                  width: 2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)).w,
              ),
              floatingLabelStyle: const TextStyle(
                color: kButtonsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
