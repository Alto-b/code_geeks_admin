part of 'get_feedback_bloc.dart';

sealed class GetFeedbackState extends Equatable {
  const GetFeedbackState();
  
  @override
  List<Object> get props => [];
}

final class GetFeedbackInitial extends GetFeedbackState {}

class FeedbackLoadedState extends GetFeedbackState{
  final List<FeedbackModel> feedbackList;
  FeedbackLoadedState({
    required this.feedbackList
  });
  @override
  List<Object> get props => [feedbackList];
}