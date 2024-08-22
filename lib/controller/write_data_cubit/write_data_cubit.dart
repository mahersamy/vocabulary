import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary_app/model/word_model.dart';

import '../../constans.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());
  static WriteDataCubit get(context) => BlocProvider.of<WriteDataCubit>(context);
  final box = Hive.box(HiveConstants.wordsBox);
  // final CollectionBox box;

  String text = "";
  bool isArabic = true;
  int colorCode = 0XFF4A47A3;

  void updateText(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitial());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> getWords =  _getWordsFromDataBase();
      getWords.add(WordModel(
          indexAtDatabase: getWords.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
        box.put(HiveConstants.wordsList, getWords);
       // print(await _getWordsFromDataBase());
    }, "We Have problems when we add word,Please try again");
  }


  void deleteWord(int indexAtDatabase){
    _tryAndCatchBlock((){
      List<WordModel> getWords = _getWordsFromDataBase();
      getWords.removeAt(indexAtDatabase);
      for (var i = indexAtDatabase; i < getWords.length; i++) {
        getWords[i]=getWords[i].decrementIndexAtDataBase();
      }
       box.put(HiveConstants.wordsList, getWords);
    },"We Have problems when we delete word,Please try again");
  }

  void addSimilarWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words =  _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(text, isArabic);
       box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we add similar word,Please try again");
  }

  void addExampleWord(int indexAtDatabase) {
    _tryAndCatchBlock(
        () {
          List<WordModel>words= _getWordsFromDataBase();
          words[indexAtDatabase]=words[indexAtDatabase].addExampleWord(text, isArabic);
           box.put(HiveConstants.wordsList, words);
        }, "We Have problems when we add example,Please try again");
  }

  void deleteSimilarWord(
      int indexAtDatabase, int indexAtSimilarWords, bool isArabicSimilar) {
    _tryAndCatchBlock(() {
      List<WordModel> words =  _getWordsFromDataBase();
      words[indexAtDatabase] = words[indexAtDatabase].deleteSimilarWord(indexAtSimilarWords, isArabicSimilar);
       box.put(HiveConstants.wordsList, words);
      }, "We Have problems when we delete similar word,Please try again");
  }

  void deleteExampleWord(
      int indexAtDatabase, int indexAtExampleWords, bool isArabicExample) {
    _tryAndCatchBlock(() {
      List<WordModel> words =  _getWordsFromDataBase();
      words[indexAtDatabase] = words[indexAtDatabase].deleteExampleWord(indexAtExampleWords, isArabicExample);
       box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we delete example word,Please try again");
  }

  void _tryAndCatchBlock(Function() methodToExcute, String message) {
    emit(WriteDataCubitLoadingState());
    try {
      methodToExcute.call();
      emit(WriteDataCubitSuccessState());
    } catch (error) {
      emit(WriteDataCubitFailedState(message: message));
    }
  }

  List<WordModel> _getWordsFromDataBase()  =>
      List.from( box.get(HiveConstants.wordsList) ??[])
          .cast<WordModel>();
}
