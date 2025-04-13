import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class BirthDateTextField extends StatefulWidget {
  final TextEditingController birthdateController;
  const BirthDateTextField({Key? key, required this.birthdateController})
      : super(key: key);
  @override
  State<BirthDateTextField> createState() => _BirthDateTextFieldState();
}

String? ErrorText;
RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');

class _BirthDateTextFieldState extends State<BirthDateTextField> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: SizedBox(
          width: 290.w,
          child: TextFormField(
            controller: widget.birthdateController,
            validator: (value) => validData(value ?? ''),
            onChanged: (value) {
              setState(() {
                ErrorText = validData(value);
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
              labelText: 'Birth Date',
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
              // errorText: ErrorText,
              suffixIcon: IconButton(
                onPressed: () {
                  SelectDate();
                },
                icon: Icon(LineIcons.calendar),
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

  Future<void> SelectDate() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1980),
      lastDate: DateTime(2010),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kButtonsColor,
            colorScheme: ColorScheme.light(
              primary: kButtonsColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              secondary: Colors.orange,
            ),
            dialogBackgroundColor: kButtonsColor,
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        widget.birthdateController.text = selected.toString().split(" ")[0];
      });
    }
  }
}

String? validData(String Value) {
  if (Value.isEmpty) {
    return 'Please enter your birth date';
  } else if (!dateRegExp.hasMatch(Value)) {
    return 'Please enter a valid birth date yyyy-mm-dd';
  }
  return null;
}
