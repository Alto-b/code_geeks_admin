part of 'subs_language_bloc.dart';

 class SubsLanguageState extends Equatable {
  const SubsLanguageState();
  
  @override
  List<Object> get props => [];
}

final class SubsLanguageInitial extends SubsLanguageState {}
 
 class LanguageLoadedStates extends SubsLanguageState{
  final List<LanguageModel> languageList;
  LanguageLoadedStates({
    required this.languageList
  });
  @override
  List<Object> get props => [];
 }