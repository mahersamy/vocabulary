import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/controller/write_data_cubit/write_data_cubit.dart';

import '../style/color_manager.dart';



class ArabicOrEnglish extends StatelessWidget {
  const ArabicOrEnglish({super.key, required this.colorCode, required this.arabicIsSelected});

  final int colorCode;
  final bool arabicIsSelected;


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _getContainerDesign(true,context),
      _getContainerDesign(false,context)
    ],);
  }



  Widget _getContainerDesign(bool isArabic,BuildContext context){
    return InkWell(
      onTap: (){WriteDataCubit.get(context).updateIsArabic(isArabic);},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2,color: ColorManager.white),
            color: isArabic==arabicIsSelected ?ColorManager.white  :  Color(colorCode)
        ),
        child: Center(child: Text(
          isArabic?"ar":"en",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: !(isArabic==arabicIsSelected)  ?ColorManager.white  :  Color(colorCode),
          ),
        ),),

      ),
    );
  }

}



