part of 'mentor_bloc.dart';

 class MentorState extends Equatable {
  const MentorState();
  
  @override
  List<Object> get props => [];
}

final class MentorInitial extends MentorState {}

class ImageUpdateState extends MentorState{
  final Uint8List imageFile;
  ImageUpdateState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];

}

// class mentorEditState extends MentorState {

// }