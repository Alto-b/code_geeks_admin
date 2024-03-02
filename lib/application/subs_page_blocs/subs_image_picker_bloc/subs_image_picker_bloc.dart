import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'subs_image_picker_event.dart';
part 'subs_image_picker_state.dart';

class SubsImagePickerBloc extends Bloc<SubsImagePickerEvent, SubsImagePickerState> {
  SubsImagePickerBloc() : super(SubsImagePickerInitial()) {
    
    on<ImageUpdateEvent>(updateImage);

    on<ImagePickerInitial>(initialImage);
  }

  FutureOr<void> updateImage(ImageUpdateEvent event, Emitter<SubsImagePickerState> emit)async {
     try{
      Uint8List? file = await ImagePickerWeb.getImageAsBytes();
      emit(ImageUpdateState(imageFile: file!));
    }
    catch(e){
      print("Exception occured while picking subs image $e");
    }
  }

  FutureOr<void> initialImage(ImagePickerInitial event, Emitter<SubsImagePickerState> emit)async {
    emit(SubsImagePickerInitial());
  }
}
 