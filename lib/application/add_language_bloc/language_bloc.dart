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
      .doc()
      .set(event.data).then((value){
        print("addLanguage successful");
      });
      }
     on FirebaseException catch(e){
        print("addLanguage ${e.message}");
      }
  }
}