import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/view/screens/word_detial_screen.dart';

import '../../model/word_model.dart';

class WordItem extends StatelessWidget {
  const WordItem({
    super.key,
    required this.wordModel,
  });

  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordDetailScreen(wordModel: wordModel),
        ),
      ).then((value) => ReadDataCubit.get(context).getWords()),
      child: Container(
        decoration: BoxDecoration(
            color: Color(wordModel.colorCode),
            borderRadius: BorderRadius.circular(20)),
        width: 50.w,
        height: 50.h,
        child: Center(
            child: Text(
          wordModel.text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 25.sp),
        )),
      ),
    );
  }
}
