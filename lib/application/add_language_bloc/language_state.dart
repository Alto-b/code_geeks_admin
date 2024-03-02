part of 'language_bloc.dart';

 class LanguageState extends Equatable {
  const LanguageState();
  
  @override
  List<Object> get props => [];
}

 class LanguageInitial extends LanguageState {}

class ImageUpdateState extends LanguageState{
  final Uint8List imageFile;
  ImageUpdateState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}

// class addMentorState extends LanguageState{}