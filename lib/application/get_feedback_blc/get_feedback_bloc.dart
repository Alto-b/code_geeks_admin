import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/domain/feedback_model.dart';
import 'package:code_geeks_admin/infrastructure/feedback_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_feedback_event.dart';
part 'get_feedback_state.dart';

class GetFeedbackBloc extends Bloc<GetFeedbackEvent, GetFeedbackState> {
  FeedbackRepo feedbackRepo = FeedbackRepo();
  GetFeedbackBloc(this.feedbackRepo) : super(GetFeedbackInitial()) {
    on<FeedbackLoadEvent>(loadFeedbacks);
  }

  FutureOr<void> loadFeedbacks(FeedbackLoadEvent event, Emitter<GetFeedbackState> emit)async{
    emit(GetFeedbackInitial());
    final feedback = await feedbackRepo.getFeedback();
    emit(FeedbackLoadedState(feedbackList: feedback));
  }
}
