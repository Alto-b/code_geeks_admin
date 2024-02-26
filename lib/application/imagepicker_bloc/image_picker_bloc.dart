import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerWeb imagePickerWeb;
  ImagePickerBloc(this.imagePickerWeb) : super(ImagePickerState()) {
   on<ImagePickerEvent>(_imagePickrFromGallery);
  }

  

  FutureOr<void> _imagePickrFromGallery(ImagePickerEvent event, Emitter<ImagePickerState> emit)async {
    try{
     final file =await ImagePickerWeb.getImageAsBytes();
     emit(state.copyWith(file));
    }catch(e){

    }
  }
}
 