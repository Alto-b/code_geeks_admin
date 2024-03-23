import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:code_geeks_admin/domain/mentor_model.dart';
import 'package:code_geeks_admin/domain/subscription_model.dart';
import 'package:code_geeks_admin/domain/user_model.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:code_geeks_admin/infrastructure/mentor_repo.dart';
import 'package:code_geeks_admin/infrastructure/subscription_repo.dart';
import 'package:code_geeks_admin/infrastructure/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  MentorRepo mentorRepo = MentorRepo();
  LanguageRepo languageRepo = LanguageRepo();
  UserRepo userRepo = UserRepo();
  StatsBloc(this.languageRepo,this.mentorRepo,this.subscriptionRepo,this.userRepo) : super(StatsInitial()) {
    on<StatsLoadEvent>(loadStatistics);
  }

  FutureOr<void> loadStatistics(StatsLoadEvent event, Emitter<StatsState> emit)async{
    final lang = await languageRepo.getlanguage();
    final subs = await subscriptionRepo.getSubscriptions();
    final mentor = await mentorRepo.getMentor();
    final users = await userRepo.getUsers();
    if(subs.isEmpty || lang.isEmpty || mentor.isEmpty || users.isEmpty){
      emit(StatsInitial());
    }
    else{
      // emit(StatsInitial());
      // Future.delayed(Duration(seconds: 1));
      emit(StatsLoadedState(langList: lang, mentorList: mentor, subsList: subs,userList: users));
    }
  }
}
