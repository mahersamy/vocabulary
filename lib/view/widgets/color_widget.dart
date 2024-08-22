import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/controller/write_data_cubit/write_data_cubit.dart';

import '../style/color_manager.dart';


class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColorCode});

  final int activeColorCode;
  final List<int>_colorCodes = const[
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
    0xFF8FBC8F,
    0xFFFA8072,
    0XFF4D4C7D,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _colorCodes.length,
        itemBuilder: (context, index) {
          return _getItemDesign(index, context);
        },
        separatorBuilder: (context, index) => SizedBox(width: 7.w,),
      ),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () {WriteDataCubit.get(context).updateColorCode(_colorCodes[index]);},
      child: Container(
        height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: activeColorCode == _colorCodes[index] ? Border.all(
              color: ColorManager.white, width: 2) : null,
          color: Color(_colorCodes[index]),
        ),
        child: activeColorCode == _colorCodes[index] ? const Center(
          child: Icon(Icons.done, color: ColorManager.white,),
        ) : null,
      ),
    );
  }


}
