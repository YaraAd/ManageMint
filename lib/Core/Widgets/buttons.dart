import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:managemint/constants.dart';

/*Yara Adel*/
class Buttons extends StatelessWidget {
  final String text;
  final VoidCallback onPressedCallBack;
  Buttons({super.key, required this.text, required this.onPressedCallBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(300.w, 55.h)),
        backgroundColor: MaterialStateProperty.all<Color>(kButtonsColor),
      ),
      onPressed: () async {
        onPressedCallBack();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          color: const Color.fromARGB(255, 253, 253, 253),
        ),
      ),
    );
  }
}
