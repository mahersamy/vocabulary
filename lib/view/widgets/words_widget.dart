import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_app/model/word_model.dart';

import 'exception_widget.dart';
import 'loading_widget.dart';
import 'word_item.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataSuccess) {
          if (state.listOfWords.isEmpty) {
            return _getEmptyWordsWigdet();
          }
          // print(state.listOfWords);
          return _getWordsWidget(state.listOfWords,context);
        } else if (state is ReadDataFailed) {
          return _getFailedWidget("Error Loading Data");
        } else {
          return _getLoadingWidget();
        }
      },
    );
  }

  Widget _getWordsWidget(List<WordModel> words,context) {
    return GridView.builder(
      itemCount: words.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width>400?4:2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: ((context, index) {
        return WordItem(wordModel: words[index]);
      }),
    );
  }

  Widget _getEmptyWordsWigdet() {
    return const ExceptionWidget(
      iconData: Icons.list_rounded,
      message: "Empty Words List",
    );
  }

  Widget _getFailedWidget(String message) {
    return ExceptionWidget(
      iconData: Icons.error,
      message: message,
    );
  }

  Widget _getLoadingWidget() {
    return const LoadingWidget();
  }
}
