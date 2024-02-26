import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    // on<LanguageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ImageUpdateEvent>(imageUpdate);
  }

  FutureOr<void> imageUpdate(ImageUpdateEvent event, Emitter<LanguageState> emit)async {
     try{
     final file =await ImagePickerWeb.getImageAsFile();
     if(file != null){
      print("image not null ${file.name}");
       print(file.name.toString());
     File upFile = File(file.name);
       emit(ImageUpdateState(imageFile: upFile));
       print("image emitted");
     }
     else{
      print('empty image');
     }

    }catch(e){
      print("Exception occured while picking image $e");
    }
  }
}
