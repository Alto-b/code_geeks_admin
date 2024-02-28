import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:equatable/equatable.dart';

part 'subs_language_event.dart';
part 'subs_language_state.dart';

class SubsLanguageBloc extends Bloc<SubsLanguageEvent, SubsLanguageState> {
  LanguageRepo languageRepo = LanguageRepo();
  SubsLanguageBloc(this.languageRepo) : super(SubsLanguageInitial()) {

   on<LanguageLoadEvents>(loadLanguage);
   
  }

  FutureOr<void> loadLanguage(LanguageLoadEvents event, Emitter<SubsLanguageState> emit) async{
    final lang = await languageRepo.getlanguage();
    emit(LanguageLoadedStates(languageList:lang ));
  }
}
 