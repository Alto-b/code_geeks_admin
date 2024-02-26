part of 'language_bloc.dart';

 class LanguageState extends Equatable {
  const LanguageState();
  
  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

class ImageUpdateState extends LanguageState{
  final File imageFile;
  ImageUpdateState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}