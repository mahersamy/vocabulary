import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/view/widgets/done_button.dart';

import '../../controller/read_data_cubit/read_data_cubit.dart';
import '../../controller/write_data_cubit/write_data_cubit.dart';
import '../style/color_manager.dart';
import 'arabic_or_english.dart';
import 'color_widget.dart';
import 'custom_form.dart';

class AddDialog extends StatelessWidget {
   AddDialog({super.key});
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
   TextEditingController textEditingController=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (context,state){
          if(state is WriteDataCubitSuccessState){
            Navigator.pop(context);
          }
          if(state is WriteDataCubitFailedState){
            ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state.message));
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            padding: const EdgeInsets.all(8.0),
            duration: const Duration(milliseconds: 500),
            color: Color(WriteDataCubit.get(context).colorCode),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglish(colorCode:WriteDataCubit.get(context).colorCode, arabicIsSelected: WriteDataCubit.get(context).isArabic,),
                SizedBox(height: 8.h,),
                ColorWidget(
                  activeColorCode: WriteDataCubit.get(context).colorCode,
                ),
                SizedBox(height: 10.h,),
                CustomForm(label: "New Word",formkey: formKey,textEditingController: textEditingController,),
                SizedBox(height: 8.h,),
                DoneButton(function: ()async{
                 if(formKey.currentState!.validate()){
                   WriteDataCubit.get(context).addWord();
                   Future.delayed(Duration(seconds: 1));
                   ReadDataCubit.get(context).getWords();
                 }
                },colorCode: WriteDataCubit.get(context).colorCode,),

              ],
            ),
          );
        },
      ),
    );
  }
   SnackBar _getSnackBar(String message) => SnackBar(content: Text(message),backgroundColor: ColorManager.red,);

}
