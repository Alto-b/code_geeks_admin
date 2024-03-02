part of 'get_language_bloc.dart';

 class GetLanguageState extends Equatable {
  const GetLanguageState();
  
  @override
  List<Object> get props => [];
}

final class GetLanguageInitial extends GetLanguageState {}

class LanguageLoadedState extends GetLanguageState{
  final List<LanguageModel> languageList;

  LanguageLoadedState({required this.languageList});
}
