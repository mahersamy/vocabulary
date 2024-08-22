import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WorldTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    // TODO: implement read
    return WordModel(
        indexAtDatabase: reader.readInt(),
        text: reader.readString(),
        isArabic: reader.readBool(),
        colorCode: reader.readInt(),
        arabicSimilarWord: reader.readStringList(),
        englishSimilarWord: reader.readStringList(),
        arabicExample: reader.readStringList(),
        englishExample: reader.readStringList());
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    // TODO: implement write
    writer.writeInt(obj.indexAtDatabase);
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.colorCode);
    writer.writeStringList(obj.arabicSimilarWord);
    writer.writeStringList(obj.englishSimilarWord);
    writer.writeStringList(obj.arabicExample);
    writer.writeStringList(obj.englishExample);
  }




}
