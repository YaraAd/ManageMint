import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class InputName {
  final String label;
  final String? InitialValue;
  const InputName({required this.label, required this.InitialValue});
}

class NameTextField extends StatefulWidget {
  final InputName i;
  TextEditingController NameController = TextEditingController();
  NameTextField({
    required this.i,
    required this.NameController,
  });

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

RegExp nameRegExp = RegExp(r'^[A-Za-z]+$');
RegExp usernameRegExp = RegExp(r'^[A-Za-z0-9._]{3,16}$');
String? ErrorText;

class _NameTextFieldState extends State<NameTextField> {
  bool isValidEmail = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 290.w,
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: TextFormField(
            controller: widget.NameController,
            validator: (value) => VaildName(value ?? ''),
            onChanged: (value) {
              setState(() {
                ErrorText = VaildName(value);
              });
            },
            style: TextStyle(
                color: Colors.black, fontSize: 15.sp, fontFamily: 'bold'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0.h,
                horizontal: 9.0.w,
              ),
              border: const OutlineInputBorder(),
              labelText: widget.i.label,
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
              errorText: ErrorText,
            ),
          ),
        ),
      ),
    );
  }

  String? VaildName(String Value) {
    if (Value.isEmpty) {
      if (widget.i.label == 'User Name') {
        return 'Please enter the user name';
      } else if (widget.i.label == 'First Name') {
        return 'Please enter your first name';
      } else if (widget.i.label == 'Last Name') {
        return 'Please enter your last name';
      }
    } else if (widget.i.label == 'First Name' ||
        widget.i.label == 'Last Name') {
      if (!nameRegExp.hasMatch(Value)) {
        return 'Invalid ${widget.i.label}, only letters is allowed';
      }
    } else if (widget.i.label == 'User name') {
      if (!usernameRegExp.hasMatch(Value)) {
        return 'Invalid username, use only letters, numbers and underscores';
      }
    }
    return null;
  }
}
