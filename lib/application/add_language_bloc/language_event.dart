part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends LanguageEvent{}

class AddLanguageEvent extends LanguageEvent{
  Map<String,String> data = {};

   AddLanguageEvent({
   required this.data
   });
  
}