import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class Passwordtextfield extends StatefulWidget {
  TextEditingController passwordController = TextEditingController();
  String label;
  String page;
  Passwordtextfield(
      {required this.passwordController,
      required this.label,
      required this.page});

  @override
  State<Passwordtextfield> createState() => _PasswordtextfieldState();
}

RegExp passReg = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[-_@$!%*?&])[A-Za-z\d-_@$!%*?&]{6,20}$');

class _PasswordtextfieldState extends State<Passwordtextfield> {
  String? ErrorText;
  bool isValidPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 290.w,
        child: TextFormField(
          cursorColor: kButtonsColor,
          controller: widget.passwordController,
          validator: (value) => Passwordvaild(value ?? ''),
          onChanged: (value) {
            setState(() {
              widget.page == 'Login'
                  ? value = ''
                  : ErrorText = Passwordvaild(value);
            });
          },
          obscureText: !isValidPassword,
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
            suffixIcon: IconButton(
                icon: isValidPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    isValidPassword = !isValidPassword;
                  });
                }),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kButtonsColor,
                width: 2.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)).w,
            ),
            errorText: ErrorText,
            floatingLabelStyle: const TextStyle(
              color: kButtonsColor,
            ),
          ),
        ),
      ),
    );
  }
}

String? Passwordvaild(String Value) {
  if (Value.isEmpty) {
    return 'Please enter your password ';
  } else if (!passReg.hasMatch(Value)) {
    return 'Password must be between 6-20 characters,\n contain at least one letter,\n one digit,\n and one special character';
  }
  return null;
}
