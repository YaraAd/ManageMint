import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class EmailTextField extends StatefulWidget {
  final TextEditingController emailCotroller;
  final String label;
  const EmailTextField(
      {Key? key, required this.emailCotroller, required this.label})
      : super(key: key);
  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
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
              RegExp emailReg =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!emailReg.hasMatch(value)) {
                return 'Please enter a valid email address';
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
