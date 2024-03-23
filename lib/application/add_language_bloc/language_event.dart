part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends LanguageEvent{}

class AddLanguageEvent extends LanguageEvent{
  Map<String,String> data = {};
  String langId;

   AddLanguageEvent({
   required this.data,
   required this.langId
   });
  
}

class EditLanguageEvent extends LanguageEvent{
  Map<String,String> data = {};
  String langId;

    EditLanguageEvent({
   required this.data,
   required this.langId
   });
  
}

class DeleteLangaugeEvent extends LanguageEvent{
  String langId;
  DeleteLangaugeEvent({
    required this.langId
  });
}