import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary_app/view/widgets/add_word_dialog.dart';
import 'package:vocabulary_app/view/widgets/done_button.dart';
import 'package:vocabulary_app/view/widgets/language_filter_widget.dart';

import '../../constans.dart';
import '../style/color_manager.dart';
import '../widgets/filter_dialog_button.dart';
import '../widgets/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloationActionButton(context),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageFilterWidget(),
                FilterDialogButton(),
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            const Expanded(child: WordsWidget()),
            // SizedBox(
            //   height: 40.h,
            //   width: 90.w,
            //   child: ElevatedButton(
            //       onPressed: ()=>Hive.box(HiveConstants.wordsBox).close(),
            //       child: const Text(
            //         "Save",
            //         style: TextStyle(color: Color(0XFFC70039)),
            //       )),
            // ),
            //WordsWidget(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _getFloationActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AddDialog(),
      ),
      child: const Icon(
        Icons.add,
        color: ColorManager.black,
      ),
    );
  }
}
