import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/widgets/custom_form.dart';
import 'package:vocabulary_app/view/widgets/done_button.dart';

import 'arabic_or_english.dart';

class UpdateWordDialog extends StatelessWidget {
  UpdateWordDialog({super.key, required this.colorCode, required this.onTap});

  final int colorCode;
  final Function() onTap;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteDataCubit, WriteDataState>(
  builder: (context, state) {
    return Dialog(
      child: AnimatedContainer(
        padding: EdgeInsets.all(8),
        duration: Duration(milliseconds: 400),
        color: Color(colorCode),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArabicOrEnglish(
              colorCode: colorCode,
              arabicIsSelected: WriteDataCubit.get(context).isArabic,
            ),
            SizedBox(height: 8.h,),
            CustomForm(label: "enter word", formkey: formKey, textEditingController: textEditingController),
            SizedBox(height: 8.h,),
            DoneButton(colorCode: colorCode, function: (){
              if(formKey.currentState!.validate()){
                onTap();
                Navigator.pop(context);
              }
            }),
          ],
        ),
      ),
    );
  },
);
  }
}
