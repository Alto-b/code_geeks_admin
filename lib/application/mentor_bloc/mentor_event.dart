part of 'mentor_bloc.dart';

sealed class MentorEvent extends Equatable {
  const MentorEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends MentorEvent{}

class AddMentorEvent extends MentorEvent{
  Map<String,String> data = {};
  String mentorId;
  AddMentorEvent({
    required this.data,
    required this.mentorId});
}

class EditMentorEvent extends MentorEvent{
  Map<String,String> data;
  String mentorId;
  EditMentorEvent({
    required this.data,
    required this.mentorId
  });
}

class DeleteMentorEvent extends MentorEvent{
  String mentorId;
  DeleteMentorEvent({
    required this.mentorId
  });
}
