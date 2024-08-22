class WordModel {
  final int indexAtDatabase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWord;
  final List<String> englishSimilarWord;
  final List<String> arabicExample;
  final List<String> englishExample;

  const WordModel({
    required this.indexAtDatabase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWord = const [],
    this.englishSimilarWord = const [],
    this.arabicExample = const [],
    this.englishExample = const [],
  });

  WordModel decrementIndexAtDataBase(){
    return WordModel(
      indexAtDatabase: indexAtDatabase-1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWord: arabicSimilarWord,
      englishSimilarWord: englishSimilarWord,
      arabicExample: arabicExample,
      englishExample: englishExample,
    );
  }

  List<String> _intializeNewSimilarWords(bool isArabicSimilarWord,) {
    List<String> newSimilarWord=[];
    if(isArabicSimilarWord){
      newSimilarWord=List.from(arabicSimilarWord);
    }else{
      newSimilarWord=List.from(englishSimilarWord);
    }
    return newSimilarWord;
  }
  List<String> _intializeExampleWords(bool isArabicSimilarWord,) {
    List<String> newExampleWord=[];
    if(isArabicSimilarWord){
      newExampleWord=List.from(arabicExample);
    }else{
      newExampleWord=List.from(englishExample);
    }
    return newExampleWord;
  }



  WordModel _getWordAfterCheckSimilarWords(bool isArabicSimilarWord, List<String> newSimilarWord) {
    return WordModel(
        indexAtDatabase: indexAtDatabase,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        arabicSimilarWord: isArabicSimilarWord?newSimilarWord:arabicSimilarWord,
        englishSimilarWord:!isArabicSimilarWord?newSimilarWord:englishSimilarWord,
        arabicExample: arabicExample,
        englishExample:englishExample
    );
  }
  WordModel _getWordAfterCheckExampleWords(bool isArabicSimilarWord, List<String> newExampleWord) {
    return WordModel(
        indexAtDatabase: indexAtDatabase,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        arabicSimilarWord:arabicSimilarWord,
        englishSimilarWord:englishSimilarWord,
        arabicExample:isArabicSimilarWord?newExampleWord:arabicExample,
        englishExample:!isArabicSimilarWord?newExampleWord:englishExample,
    );
  }


  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWord = _intializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWord.add(similarWord);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWord);
  }
  WordModel addExampleWord(String exampleWord, bool isArabicSimilarWord) {
    List<String> newExampleWord = _intializeExampleWords(isArabicSimilarWord);
    newExampleWord.add(exampleWord);
    return _getWordAfterCheckExampleWords(isArabicSimilarWord, newExampleWord);
  }



  WordModel deleteSimilarWord(int indexAtSimilarWords,bool isArabicSimilarWord){
    List<String> newSimilarWord = _intializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWord.removeAt(indexAtSimilarWords);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWord);
  }
  WordModel deleteExampleWord(int indexAtSimilarWords,bool isArabicExampleWord){
    List<String> newExampleWord = _intializeExampleWords(isArabicExampleWord);
    newExampleWord.removeAt(indexAtSimilarWords);
    return _getWordAfterCheckExampleWords(isArabicExampleWord, newExampleWord);
  }


}
