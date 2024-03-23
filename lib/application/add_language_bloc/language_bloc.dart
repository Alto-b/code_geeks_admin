import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {

    on<ImageUpdateEvent>(imageUpdate);
    on<AddLanguageEvent>(addLanguage);
    on<EditLanguageEvent>(editLanguage);
    on<DeleteLangaugeEvent>(deleteLanguage);
  }

  FutureOr<void> imageUpdate(ImageUpdateEvent event, Emitter<LanguageState> emit)async {
     try{
     Uint8List? file =await ImagePickerWeb.getImageAsBytes();
    //  if(file != null){
    //   print("image not null ${file.name}");
    //    print(file.name.toString());
    //  File upFile = File(file.name);
    //    emit(ImageUpdateState(imageFile: upFile));
    //    print("image emitted");
    //  }
    //  else{
    //   print('empty image');
    //  }
    emit(ImageUpdateState(imageFile: file!));

    }catch(e){
      print("Exception occured while picking lang image $e");
    }
  }

  FutureOr<void> addLanguage(AddLanguageEvent event, Emitter<LanguageState> emit)async {
      try{
          await FirebaseFirestore.instance.collection("language")
      .doc(event.langId)
      .set(event.data).then((value){
        print("addLanguage successful");
      });
      }
     on FirebaseException catch(e){
        print("addLanguage ${e.message}");
      }
  }



  FutureOr<void> editLanguage(EditLanguageEvent event, Emitter<LanguageState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("language")
      .doc(event.langId)
      .update(event.data).then((value){
        print("editLanguage successfull");
      });
    }
    on FirebaseException catch(e){
      print("editLanguage : ${e.message}");
    }
 
  }

  FutureOr<void> deleteLanguage(DeleteLangaugeEvent event, Emitter<LanguageState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("language")
      .doc(event.langId)
      .delete();
    }
    on FirebaseException catch(e){
      print("deleteLanguage : ${e.message}");
    }
  }
}