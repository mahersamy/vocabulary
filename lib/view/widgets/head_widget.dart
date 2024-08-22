import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/color_manager.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({super.key, required this.word, required this.colorCode, this.ontap});

  final String word;
  final int colorCode;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          word,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(colorCode),
          ),
        ),
        const Spacer(),
        if (ontap != null)
          Container(
            height: 40.h,
            width: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15).w,
                color: Color(colorCode)),
            child: IconButton(
              onPressed: () {
                ontap!();
              },
              icon: const Icon(
                Icons.add,
                color: ColorManager.black,
              ),
            ),
          ),
      ],
    );
  }
}
