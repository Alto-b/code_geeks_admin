import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/application/add_language_bloc/language_bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_language_event.dart';
part 'get_language_state.dart';

class GetLanguageBloc extends Bloc<GetLanguageEvent, GetLanguageState> {
  LanguageRepo langRepo = LanguageRepo();
  GetLanguageBloc(this.langRepo) : super(GetLanguageInitial()) {
    on<LanguageLoadEvent>(getLanguages);
  }

  FutureOr<void> getLanguages(LanguageLoadEvent event, Emitter<GetLanguageState> emit)async{
    emit(GetLanguageInitial());
    final lang = await langRepo.getlanguage();
    emit(LanguageLoadedState(languageList: lang));
  }
}
