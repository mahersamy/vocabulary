part of 'write_data_cubit.dart';

abstract class WriteDataState {}

class WriteDataInitial extends WriteDataState {}

class WriteDataCubitLoadingState extends WriteDataState{}
class WriteDataCubitSuccessState extends WriteDataState{}
class WriteDataCubitFailedState extends WriteDataState{
  final String message;
  WriteDataCubitFailedState({required this.message});
}

class AddSimilarWordState extends WriteDataState{}

