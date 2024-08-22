import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vocabulary_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';
import 'package:vocabulary_app/view/widgets/update_word_dialog.dart';

import '../../controller/read_data_cubit/read_data_cubit.dart';
import '../style/color_manager.dart';
import '../widgets/exception_widget.dart';
import '../widgets/head_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/word_detail_item.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  late WordModel _wordModel;

  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if (state is ReadDataSuccess) {
            try {
              int index = state.listOfWords.indexWhere((element) =>
              element.indexAtDatabase == _wordModel.indexAtDatabase);
              _wordModel = state.listOfWords[index];
              return buildBody(context);
            } catch (e) {
              print(e);
            }
          }
          if (state is ReadDataFailed) {
            return const ExceptionWidget(
                iconData: Icons.error, message: "Error loading Data");
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Word Detail",
        style: TextStyle(
          color: Color(widget.wordModel.colorCode),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => deleteWord(context),
          icon: Icon(
            Icons.delete,
            color: Color(widget.wordModel.colorCode),
          ),
        ),
      ],
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          buildWordElement(_wordModel),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: buildSimilarOrExampleElement(context, _wordModel, true),
          ),
          SizedBox(
            height: 25.h,
          ),
          Expanded(
            child: buildSimilarOrExampleElement(context, _wordModel, false),
          ),
        ],
      ),
    );
  }

  Widget buildWordElement(WordModel wordModel) {
    return Column(
      children: [
        HeadWidget(word: _wordModel.text, colorCode: _wordModel.colorCode),
        SizedBox(
          height: 5.h,
        ),
        WordDetailItem(
            isArabic: false,
            word: _wordModel.text,
            colorCode: _wordModel.colorCode)
      ],
    );
  }

  Widget buildSimilarOrExampleElement(
      context, WordModel wordModel, bool isSimilar) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Column(
        children: [
          HeadWidget(
            word: isSimilar ? "Similar Word" : "Example Word",
            colorCode: wordModel.colorCode,
            ontap: () => showDialog(
              context: context,
              builder: (context) => UpdateWordDialog(
                  colorCode: wordModel.colorCode,
                  onTap: () {
                    if (isSimilar) {
                      WriteDataCubit.get(context)
                          .addSimilarWord(wordModel.indexAtDatabase);
                    } else {
                      WriteDataCubit.get(context)
                          .addExampleWord(wordModel.indexAtDatabase);
                    }
                    ReadDataCubit.get(context).getWords();
                  }),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: SizedBox(
              height: 80.h,
              width: double.infinity,
              child: ListView(
                children: [
                  for (int i = 0;
                      i < wordModel.arabicSimilarWord.length && isSimilar;
                      i++)
                    WordDetailItem(
                        isArabic: true,
                        word: wordModel.arabicSimilarWord[i],
                        colorCode: wordModel.colorCode,
                        ontap: () {
                          WriteDataCubit.get(context).deleteSimilarWord(_wordModel.indexAtDatabase, i, true);
                          ReadDataCubit.get(context).getWords();
                        }),
                  for (int i = 0;
                      i < wordModel.englishSimilarWord.length && isSimilar;
                      i++)
                    WordDetailItem(
                        isArabic: false,
                        word: wordModel.englishSimilarWord[i],
                        colorCode: wordModel.colorCode,
                        ontap: () {
                          WriteDataCubit.get(context).deleteSimilarWord(_wordModel.indexAtDatabase, i, false);
                          ReadDataCubit.get(context).getWords();
                        }),
                  for (int i = 0;
                      i < wordModel.arabicExample.length && !isSimilar;
                      i++)
                    WordDetailItem(
                        isArabic: true,
                        word: wordModel.arabicExample[i],
                        colorCode: wordModel.colorCode,
                        ontap: () {
                          WriteDataCubit.get(context).deleteExampleWord(_wordModel.indexAtDatabase, i, true);
                          ReadDataCubit.get(context).getWords();
                        }),
                  for (int i = 0;
                      i < wordModel.englishExample.length && !isSimilar;
                      i++)
                    WordDetailItem(
                        isArabic: false,
                        word: wordModel.englishExample[i],
                        colorCode: wordModel.colorCode,
                        ontap: () {
                          WriteDataCubit.get(context).deleteExampleWord(_wordModel.indexAtDatabase, i, false);
                          ReadDataCubit.get(context).getWords();
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteWord(context) {
    WriteDataCubit.get(context).deleteWord(widget.wordModel.indexAtDatabase);
    Navigator.pop(context);
  }


}
