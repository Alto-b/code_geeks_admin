part of 'get_feedback_bloc.dart';

sealed class GetFeedbackEvent extends Equatable {
  const GetFeedbackEvent();

  @override
  List<Object> get props => [];
}

class FeedbackLoadEvent extends GetFeedbackEvent{}