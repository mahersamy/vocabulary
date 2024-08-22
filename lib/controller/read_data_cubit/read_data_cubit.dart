import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary_app/model/word_model.dart';

import "../../constans.dart";

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());

  static ReadDataCubit get(context) => BlocProvider.of(context);
  final _box = Hive.box(HiveConstants.wordsBox);
  // final CollectionBox _box;
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

  void getWords() {
    emit(ReadDataLoading());
    try {
      List<WordModel> wordsToReturn = List.from(_box.get(HiveConstants.wordsList)).cast<WordModel>();
      print(wordsToReturn);
      _removeUnwantedWords(wordsToReturn);
      _sortedData(wordsToReturn);
      emit(ReadDataSuccess(wordsToReturn));
    } catch (e) {
      emit(ReadDataFailed());
    }
  }

  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _sortedData(List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.descending) {
        _reverse(wordsToReturn);
      } else {
        return;
      }
    } else {
      wordsToReturn.sort((wordModel, wordModel2) {
        return wordModel.text.length.compareTo(wordModel2.text.length);
      });
      if (sortingType == SortingType.descending) {
        _reverse(wordsToReturn);
      } else {
        return;
      }
    }
  }


  void _reverse(List<WordModel> wordsToReturn){
    for(int i=0; i<wordsToReturn.length/2;i++){
      WordModel temp=wordsToReturn[i];
      wordsToReturn[i]=wordsToReturn[(wordsToReturn.length-1)-i];
      wordsToReturn[(wordsToReturn.length-1)-i]=temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords,
}

enum SortedBy {
  time,
  wordLength,
}

enum SortingType {
  ascending,
  descending,
}
