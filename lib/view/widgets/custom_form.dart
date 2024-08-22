import 'package:flutter/material.dart';
import 'package:vocabulary_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/view/style/color_manager.dart';


class CustomForm extends StatelessWidget {
  CustomForm({super.key, required this.label, required this.formkey, required this.textEditingController});
  final String label;
  final GlobalKey<FormState> formkey;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: TextFormField(
        style: const TextStyle(color: ColorManager.white),
        controller: textEditingController,
        maxLength: 30,
        maxLines: 1,
        validator: (value)=>_validator(value,WriteDataCubit.get(context).isArabic),
        decoration:_buildInputDecoration(),
        onChanged: (value){WriteDataCubit.get(context).text=value;},
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
        label: Text(label,style:const TextStyle(color: ColorManager.white),),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:const BorderSide(color: ColorManager.white,width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:const BorderSide(color: ColorManager.white,width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:const BorderSide(color: ColorManager.red,width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:const BorderSide(color: ColorManager.red,width: 2),
        ),
      );
  }

  String? _validator(String? value,bool isArabic){
    if(value==null||value.trim().length==0){
      return "This Field Has not to be empty";
    }

    for (var i = 0; i <value.length ; i++) {
      CharType charType=_getCharType(value.codeUnitAt(i));
      if(charType == CharType.notValid){
        return "Char Number ${i+1} Not Valid";
      }else if(charType==CharType.arabic&&isArabic==false){
        return "Char Number ${i+1} is not english Char";
      }else if(charType==CharType.english&&isArabic==true){
        return "Char Number ${i+1} is not arabic Char";
      }
    }
    return null;
  }


  CharType _getCharType(int asciiCode){
    if((asciiCode>=65 && asciiCode<=90) || (asciiCode>=97&&asciiCode<=122)){
      return CharType.english;
    }else if(asciiCode>=1569&&asciiCode<=1610){
      return CharType.arabic;
    }else if(asciiCode==32){
      return CharType.space;
    }
    return CharType.notValid;
  }

}

enum CharType{
  arabic,
  english,
  space,
  notValid,
}
