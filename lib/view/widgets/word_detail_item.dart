import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/color_manager.dart';

class WordDetailItem extends StatelessWidget {
  const WordDetailItem({super.key, required this.isArabic, required this.word, required this.colorCode, this.ontap});

  final bool isArabic;
  final String word;
  final int colorCode;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(colorCode),
          borderRadius: BorderRadius.circular(20).w,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: ColorManager.black, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  isArabic ? "ar" : "en",
                  style: TextStyle(color: Color(colorCode)),
                ),
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(word),
            const Spacer(),
            if (ontap != null)
              IconButton(
                onPressed: () {
                  ontap!();
                },
                icon: const Icon(
                  Icons.delete,
                  color: ColorManager.black,
                ),
              ),
          ],
        ));
  }
}
