part of 'get_mentor_bloc.dart';

 class GetMentorState extends Equatable {
  const GetMentorState();
  
  @override
  List<Object> get props => [];
}

final class GetMentorInitial extends GetMentorState {}

class MentorLoadedState extends GetMentorState{
  List<MentorModel> mentorList;
  MentorLoadedState({required this.mentorList});
}
