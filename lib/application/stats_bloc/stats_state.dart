part of 'stats_bloc.dart';

sealed class StatsState extends Equatable {
  const StatsState();
  
  @override
  List<Object> get props => [];
}

final class StatsInitial extends StatsState {}

class StatsLoadedState extends StatsState{
  final List<SubscriptionModel> subsList;
  final List<MentorModel> mentorList;
  final List<LanguageModel> langList;
  final List<UserModel> userList;
  StatsLoadedState({
    required this.langList,
    required this.mentorList,
    required this.subsList,
    required this.userList
  });
}