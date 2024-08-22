import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.colorCode, required this.function});
  final int colorCode;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Spacer(),
        SizedBox(
          height: 40.h,
          width: 90.w,
          child: ElevatedButton(
              onPressed: ()=>function(),
              child: Text(
                "Done",
                style: TextStyle(color: Color(colorCode)),
              )),
        ),
      ],
    );
  }
}
