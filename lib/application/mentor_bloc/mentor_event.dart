part of 'mentor_bloc.dart';

sealed class MentorEvent extends Equatable {
  const MentorEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends MentorEvent{}

class AddMentorEvent extends MentorEvent{
  Map<String,String> data = {};
  AddMentorEvent({required this.data});
}
