import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/domain/mentor_model.dart';
import 'package:code_geeks_admin/infrastructure/mentor_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_mentor_event.dart';
part 'get_mentor_state.dart';

class GetMentorBloc extends Bloc<GetMentorEvent, GetMentorState> {
  MentorRepo mentorRepo = MentorRepo();
  GetMentorBloc(this.mentorRepo) : super(GetMentorInitial()) {
    on<MentorLoadEvent>(getMentor);
  }

  FutureOr<void> getMentor(MentorLoadEvent event, Emitter<GetMentorState> emit) async{
    final mentors =await mentorRepo.getMentor();
    emit(MentorLoadedState(mentorList: mentors));
  }
}
