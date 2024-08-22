part of 'read_data_cubit.dart';

abstract class ReadDataState {}
class ReadDataInitial extends ReadDataState {}
class ReadDataLoading extends ReadDataState {}

class ReadDataSuccess extends ReadDataState {
  final List<WordModel> listOfWords;

  ReadDataSuccess(this.listOfWords);
}

class ReadDataFailed extends ReadDataState {}


